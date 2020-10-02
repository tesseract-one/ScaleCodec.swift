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
    
    open func encode<T: ScaleEncodable>(_ value: T) throws -> Data {
        return try SEncoder().encode(value).output
    }
    
    open func decode<T: ScaleDecodable>(_ type: T.Type, from data: Data) throws -> T {
        return try SDecoder(data: data).decode(type)
    }
    
    public static let `default`: SCALE = SCALE()
}

extension SCALE {
    public func decode<T: ScaleDecodable>(from data: Data) throws -> T {
        return try self.decode(T.self, from: data)
    }
}
