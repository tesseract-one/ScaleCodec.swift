//
//  Codec.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

public typealias Codable = Encodable & Decodable

@inlinable
public func encoder(reservedCapacity count: Int = 4096) -> DataEncoder {
    DataEncoder(reservedCapacity: count)
}

@inlinable
public func decoder(from data: Data) -> DataDecoder { DataDecoder(data: data) }

@inlinable
public func encode<T: Encodable>(_ value: T, reservedCapacity count: Int = 4096) throws -> Data {
    var _encoder = encoder(reservedCapacity: count)
    try _encoder.encode(value)
    return _encoder.output
}

@inlinable
public func decode<T: Decodable>(from data: Data) throws -> T {
    var _decoder = decoder(from: data)
    return try _decoder.decode()
}

@inlinable
public func decode<T: Decodable>(_ type: T.Type, from data: Data) throws -> T {
    return try decode(from: data)
}
