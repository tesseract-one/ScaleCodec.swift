//
//  Decoder.swift
//  
//
//  Created by Yehor Popovych on 9/30/20.
//

import Foundation

public protocol Decodable {
    init<D: Decoder>(from decoder: inout D) throws
}

public protocol Decoder {
    var length: Int { get }
    var path: [String] { get }
    
    mutating func decode<T: Decodable>() throws -> T
    mutating func read(count: Int) throws -> Data
    func peek(count: Int) throws -> Data
    func peek() throws -> UInt8
    func skippable() -> SkippableDecoder
}

public protocol SkippableDecoder: Decoder {
    mutating func skip(count: Int) throws
}

extension Decoder {
    @inlinable
    public mutating func decode<T: Decodable>(_ type: T.Type) throws -> T {
        return try self.decode()
    }
    
    @inlinable
    public func errorContext(_ description: String) -> DecodingError.Context {
        DecodingError.Context(path: path, description: description)
    }
}

private protocol DecoderCommonImpls: Decoder {
    var data: Data { get }
    var position: Int { get set }
    var context: SContext { get set }
    
    init(data: Data, position: Int, context: SContext)
}

extension DecoderCommonImpls {
    public var length: Int {
        return data.count - position
    }
    
    public var path: [String] {
        return context.currentPath
    }
    
    public init(data: Data) {
        self.init(data: data, position: 0, context: SContext())
    }
    
    public mutating func read(count: Int) throws -> Data {
        let data = try peek(count: count)
        self.position += count
        return data
    }
    
    public func peek(count: Int) throws -> Data {
        guard count <= length else {
            throw DecodingError.notEnoughData(
                DecodingError.Context(
                    path: path,
                    description: "Tried to read \(count) bytes when \(length) left")
            )
        }
        return self.data.subdata(in: self.position..<self.position+count)
    }
    
    public func peek() throws -> UInt8 {
        guard length > 0 else {
            throw DecodingError.notEnoughData(
                DecodingError.Context(
                    path: path,
                    description: "Tried to read 1 byte from empty decoder")
            )
        }
        return data[position]
    }
    
    public mutating func decode<T: Decodable>() throws -> T {
        context.push(elem: T.self)
        defer { context.pop() }
        return try T(from: &self)
    }
    
    public func skippable() -> SkippableDecoder {
        SkippableDataDecoder(data: data,
                             position: position,
                             context: context)
    }
}

public struct DataDecoder: Decoder, DecoderCommonImpls {
    fileprivate let data: Data
    fileprivate var position: Int
    fileprivate var context: SContext
    
    public init(data: Data) {
        self.init(data: data, position: 0, context: SContext())
    }
    
    fileprivate init(data: Data, position: Int, context: SContext) {
        self.data = data
        self.position = position
        self.context = context
    }
}

public struct SkippableDataDecoder: SkippableDecoder, DecoderCommonImpls {
    fileprivate let data: Data
    fileprivate var position: Int
    fileprivate var context: SContext
    
    fileprivate init(data: Data, position: Int, context: SContext) {
        self.data = data
        self.position = position
        self.context = context
    }
    
    public mutating func skip(count: Int) throws {
        guard count <= length else {
            throw DecodingError.notEnoughData(
                DecodingError.Context(
                    path: path,
                    description: "Tried to skip \(count) bytes when \(length) left")
            )
        }
        self.position += count
    }
}
