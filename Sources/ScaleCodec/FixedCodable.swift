//
//  Dixed.swift
//  
//
//  Created by Yehor Popovych on 10/5/20.
//

import Foundation

public protocol FixedEncodable: Encodable {
    associatedtype Element: Encodable
    
    static var fixedElementCount: Int { get }
    
    func values() throws -> [Element]
}

public protocol FixedDecodable: Decodable {
    associatedtype Element: Decodable
    
    static var fixedElementCount: Int { get }
    
    init(values: [Element]) throws
}

public typealias FixedCodable = FixedEncodable & FixedDecodable

public extension FixedEncodable {
    func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(self.values(), .fixed(UInt(Self.fixedElementCount)))
    }
}

public extension FixedDecodable {
    init<D: Decoder>(from decoder: inout D) throws {
        try self.init(values: decoder.decode(.fixed(UInt(Self.fixedElementCount))))
    }
}

public extension FixedDecodable where Element: SizeCalculable {
    static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try (0..<fixedElementCount).reduce(0) { (sum, _) in
            try sum + Element.calculateSize(in: &decoder)
        }
    }
}

public protocol FixedDataEncodable: Encodable {
    func serialize() -> Data
    
    static var fixedBytesCount: Int { get }
}

public protocol FixedDataDecodable: Decodable {
    init(decoding data: Data) throws
    
    static var fixedBytesCount: Int { get }
}

public typealias FixedDataCodable = FixedDataEncodable & FixedDataDecodable

public extension FixedDataEncodable {
    func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(self.serialize(), .fixed(UInt(Self.fixedBytesCount)))
    }
}

public extension FixedDataDecodable {
    init<D: Decoder>(from decoder: inout D) throws {
        try self.init(decoding: decoder.decode(.fixed(UInt(Self.fixedBytesCount))))
    }
    
    static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try decoder.skip(count: fixedBytesCount)
        return fixedBytesCount
    }
}

