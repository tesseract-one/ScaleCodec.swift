//
//  Decoder.swift
//  
//
//  Created by Yehor Popovych on 9/30/20.
//

import Foundation

public protocol ScaleDecodable {
    init(from decoder: ScaleDecoder) throws
}

public protocol ScaleDecoder {
    var length: Int { get }
    var path: [String] { get }
    
    init(data: Data)
    
    func decode<T: ScaleDecodable>() throws -> T
    func read(count: Int) throws -> [UInt8]
    func peek(count: Int) throws -> [UInt8]
}

extension ScaleDecoder {
    public func decode<T: ScaleDecodable>(_ type: T.Type) throws -> T {
        return try self.decode()
    }
}

internal class SDecoder: ScaleDecoder {
    public enum Error: Swift.Error {
        case noDataLeft
    }
    
    private let data: Data
    private var position: Int
    private var context: SContext
    
    var length: Int {
        return data.count - position
    }
    
    var path: [String] {
        return context.currentPath
    }
    
    required init(data: Data) {
        self.data = data
        self.position = 0
        self.context = SContext()
    }
    
    func read(count: Int) throws -> [UInt8] {
        let data = try peek(count: count)
        self.position += count
        return data
    }
    
    func peek(count: Int) throws -> [UInt8] {
        guard count <= length else {
            throw Error.noDataLeft
        }
        return self.data.withUnsafeBytes { bytes in
            Array(bytes[self.position..<self.position+count])
        }
    }
    
    func decode<T: ScaleDecodable>() throws -> T {
        context.push(elem: T.self)
        defer { context.pop() }
        return try T(from: self)
    }
}

internal extension ScaleDecoder {
    func readOrError<T>(count: Int, type: T.Type) throws -> [UInt8] {
        do {
            return try read(count: count)
        } catch SDecoder.Error.noDataLeft {
            throw SDecodingError.valueNotFound(
                type,
                SDecodingError.Context(
                    path: path,
                    description: "Don't have \(count) bytes"
                )
            )
        }
    }
    
    func peekOrError<T>(count: Int, type: T.Type) throws -> [UInt8] {
        do {
            return try peek(count: count)
        } catch SDecoder.Error.noDataLeft {
            throw SDecodingError.valueNotFound(
                type,
                SDecodingError.Context(
                    path: path,
                    description: "Don't have \(count) bytes"
                )
            )
        }
    }
}