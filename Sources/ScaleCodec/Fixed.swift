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
    
    func encode() throws -> [Element]
}

public protocol ScaleFixedDecodable: ScaleDecodable {
    associatedtype Element: ScaleDecodable
    
    static var fixedElementCount: Int { get }
    
    init(decoding values: [Element]) throws
}

public typealias ScaleFixed = ScaleFixedEncodable & ScaleFixedDecodable

extension ScaleFixedEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        let values = try self.encode()
        try encoder.encode(values, fixed: UInt(Self.fixedElementCount))
    }
}

extension ScaleFixedDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let values: [Element] = try decoder.decode(.fixed(UInt(Self.fixedElementCount)))
        try self.init(decoding: values)
    }
}

public enum ScaleFixedTypeMarker {
    case fixed(UInt)
}

public protocol ScaleFixedDataEncodable: ScaleEncodable {
    static var fixedBytesCount: Int { get }
    
    func encode() throws -> Data
}

public protocol ScaleFixedDataDecodable: ScaleDecodable {
    static var fixedBytesCount: Int { get }
    
    init(decoding data: Data) throws
}

public typealias ScaleFixedData = ScaleFixedDataEncodable & ScaleFixedDataDecodable

extension ScaleFixedDataEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        let data = try self.encode()
        try encoder.encode(data, fixed: UInt(Self.fixedBytesCount))
    }
}

extension ScaleFixedDataDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let data: Data = try decoder.decode(.fixed(UInt(Self.fixedBytesCount)))
        try self.init(decoding: data)
    }
}
