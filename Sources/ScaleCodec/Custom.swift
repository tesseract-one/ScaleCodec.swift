//
//  Custom.swift
//  
//
//  Created by Yehor Popovych on 1/12/21.
//

import Foundation

public struct CustomDecoderFactory<T, D: Decoder> {
    public let decoder: (inout D) throws -> T
    
    public init(_ decoder: @escaping (inout D) throws -> T) {
        self.decoder = decoder
    }
}

public struct CustomEncoderFactory<T, E: Encoder> {
    public let encoder: (inout E, T) throws -> Void
    
    public init(_ encoder: @escaping (inout E, T) throws -> Void) {
        self.encoder = encoder
    }
}

extension Decoder {
    public mutating func decode<T>(_ type: T.Type, _ custom: CustomDecoderFactory<T, Self>) throws -> T {
        return try custom.decoder(&self)
    }
    
    public mutating func decode<T>(_ custom: CustomDecoderFactory<T, Self>) throws -> T {
        return try custom.decoder(&self)
    }
}

extension Encoder {
    public mutating func encode<T>(_ value: T, _ custom: CustomEncoderFactory<T, Self>) throws {
        try custom.encoder(&self, value)
    }
}

public func encode<T>(
    _ value: T, _ custom: CustomEncoderFactory<T, DataEncoder>,
    reservedCapacity count: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data {
    var _encoder = encoder(reservedCapacity: count)
    try _encoder.encode(value, custom)
    return _encoder.output
}

public func decode<T>(_ type: T.Type, _ custom: CustomDecoderFactory<T, DataDecoder>, from data: Data) throws -> T {
    return try decode(custom, from: data)
}

public func decode<T>(_ custom: CustomDecoderFactory<T, DataDecoder>, from data: Data) throws -> T {
    var _decoder = decoder(from: data)
    return try _decoder.decode(custom)
}
