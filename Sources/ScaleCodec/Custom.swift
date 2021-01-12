//
//  Custom.swift
//  
//
//  Created by Yehor Popovych on 1/12/21.
//

import Foundation

public struct ScaleCustomDecoderFactory<T> {
    public let decoder: (ScaleDecoder) throws -> T
    
    public init(_ decoder: @escaping (ScaleDecoder) throws -> T) {
        self.decoder = decoder
    }
}

public struct ScaleCustomEncoderFactory<T> {
    public let encoder: (ScaleEncoder, T) throws -> ScaleEncoder
    
    public init(_ encoder: @escaping (ScaleEncoder, T) throws -> ScaleEncoder) {
        self.encoder = encoder
    }
}

extension ScaleDecoder {
    public func decode<T>(_ type: T.Type, _ custom: ScaleCustomDecoderFactory<T>) throws -> T {
        return try custom.decoder(self)
    }
    
    public func decode<T>(_ custom: ScaleCustomDecoderFactory<T>) throws -> T {
        return try custom.decoder(self)
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T>(_ value: T, _ custom: ScaleCustomEncoderFactory<T>) throws -> ScaleEncoder {
        return try custom.encoder(self, value)
    }
}

extension SCALE {
    public func encode<T>(_ value: T, _ custom: ScaleCustomEncoderFactory<T>) throws -> Data {
        return try self.encoder().encode(value, custom).output
    }
    
    public func decode<T>(_ type: T.Type, _ custom: ScaleCustomDecoderFactory<T>, from data: Data) throws -> T {
        return try self.decode(custom, from: data)
    }
    
    public func decode<T>(_ custom: ScaleCustomDecoderFactory<T>, from data: Data) throws -> T {
        return try self.decoder(data: data).decode(custom)
    }
}
