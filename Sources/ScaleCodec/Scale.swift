//
//  Codec.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

public typealias Codable = Encodable & Decodable

public var SCALE_CODEC_DEFAULT_ENCODER_CAPACITY: Int = 4096 // 4kb

@inlinable
public func encoder(reservedCapacity count: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY) -> DataEncoder {
    DataEncoder(reservedCapacity: count)
}

@inlinable
public func decoder(from data: Data) -> DataDecoder { DataDecoder(data: data) }

@inlinable
public func encode<T: Encodable>(
    _ value: T,
    reservedCapacity count: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data {
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
