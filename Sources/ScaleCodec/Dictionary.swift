//
//  Dictionary.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import Foundation

extension Dictionary: ScaleDoubleContainerEncodable {
    public typealias ELeft = Key
    public typealias ERight = Value
    
    public func encode(
        in encoder: ScaleEncoder,
        lwriter: @escaping (Key, ScaleEncoder) throws -> Void,
        rwriter: @escaping (Value, ScaleEncoder) throws -> Void
    ) throws {
        let array = Array(self)
        try array.encode(in: encoder) { (kv, enc) in
            try lwriter(kv.key, enc); try rwriter(kv.value, enc)
        }
    }
}

extension Dictionary: ScaleDoubleContainerDecodable {
    public typealias DLeft = Key
    public typealias DRight = Value
    
    public init(
        from decoder: ScaleDecoder,
        lreader: @escaping (ScaleDecoder) throws -> Key,
        rreader: @escaping (ScaleDecoder) throws -> Value
    ) throws {
        let array = try Array<(DLeft, DRight)>(from: decoder) { try (lreader($0), rreader($0)) }
        self = Dictionary(uniqueKeysWithValues: array)
    }
}

extension Dictionary: ScaleContainerEncodable where Key: ScaleEncodable {
    public typealias EElement = Value
}

extension Dictionary: ScaleContainerDecodable where Key: ScaleDecodable {
    public typealias DElement = Value
}

extension Dictionary: ScaleEncodable where Key: ScaleEncodable, Value: ScaleEncodable {}

extension Dictionary: ScaleDecodable where Key: ScaleDecodable, Value: ScaleDecodable {}
