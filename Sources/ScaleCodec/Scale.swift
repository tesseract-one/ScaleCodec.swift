//
//  Codec.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

public typealias ScaleCodable = ScaleEncodable & ScaleDecodable

open class SCALE {
    public init() {}
    
    open func encoder() -> ScaleEncoder {
        return SEncoder()
    }
    
    open func decoder(data: Data) -> ScaleDecoder {
        return SDecoder(data: data)
    }
    
    public static let `default`: SCALE = SCALE()
}

extension SCALE {
    open func encode<T: ScaleEncodable>(_ value: T) throws -> Data {
        return try encoder().encode(value).output
    }
    
    open func decode<T: ScaleDecodable>(from data: Data) throws -> T {
        return try decoder(data: data).decode()
    }
    
    public func decode<T: ScaleDecodable>(_ type: T.Type, from data: Data) throws -> T {
        return try self.decode(from: data)
    }
}
