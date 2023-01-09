//
//  Dixed.swift
//  
//
//  Created by Yehor Popovych on 10/5/20.
//

import Foundation

public protocol ScaleFixedEncodable: ScaleEncodable {
    associatedtype Element: ScaleEncodable
    
    static var fixedElementCount: Int { get }
    
    func values() throws -> [Element]
}

public protocol ScaleFixedDecodable: ScaleDecodable {
    associatedtype Element: ScaleDecodable
    
    static var fixedElementCount: Int { get }
    
    init(values: [Element]) throws
}

public typealias ScaleFixed = ScaleFixedEncodable & ScaleFixedDecodable

extension ScaleFixedEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(self.values(), .fixed(UInt(Self.fixedElementCount)))
    }
}

extension ScaleFixedDecodable {
    public init(from decoder: ScaleDecoder) throws {
        try self.init(values: decoder.decode(.fixed(UInt(Self.fixedElementCount))))
    }
}

public protocol ScaleFixedDataEncodable: ScaleEncodable {
    func serialize() -> Data
    
    static var fixedBytesCount: Int { get }
}

public protocol ScaleFixedDataDecodable: ScaleDecodable {
    init(decoding data: Data) throws
    
    static var fixedBytesCount: Int { get }
}

public typealias ScaleFixedData = ScaleFixedDataEncodable & ScaleFixedDataDecodable

extension ScaleFixedDataEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(self.serialize(), .fixed(UInt(Self.fixedBytesCount)))
    }
}

extension ScaleFixedDataDecodable {
    public init(from decoder: ScaleDecoder) throws {
        try self.init(decoding: decoder.decode(.fixed(UInt(Self.fixedBytesCount))))
    }
}

