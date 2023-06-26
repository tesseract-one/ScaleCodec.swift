//
//  Dictionary.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import Foundation

extension Dictionary: DoubleContainerEncodable {
    public typealias ELeft = Key
    public typealias ERight = Value
    
    public func encode<E: Encoder>(
        in encoder: inout E,
        lwriter: @escaping (Key, inout E) throws -> Void,
        rwriter: @escaping (Value, inout E) throws -> Void
    ) throws {
        let array = Array(self)
        try array.encode(in: &encoder) { (kv, enc) in
            try lwriter(kv.key, &enc); try rwriter(kv.value, &enc)
        }
    }
}

extension Dictionary: DoubleContainerDecodable {
    public typealias DLeft = Key
    public typealias DRight = Value
    
    public init<D: Decoder>(
        from decoder: inout D,
        lreader: @escaping (inout D) throws -> Key,
        rreader: @escaping (inout D) throws -> Value
    ) throws {
        let array = try Array<(DLeft, DRight)>(from: &decoder) { try (lreader(&$0), rreader(&$0)) }
        self = Dictionary(uniqueKeysWithValues: array)
    }
}

extension Dictionary: ContainerEncodable where Key: Encodable {
    public typealias EElement = Value
}

extension Dictionary: ContainerDecodable where Key: Decodable {
    public typealias DElement = Value
}

extension Dictionary: Encodable where Key: Encodable, Value: Encodable {}

extension Dictionary: Decodable where Key: Decodable, Value: Decodable {}

extension Dictionary: DoubleContainerSizeCalculable {
    public typealias SLeft = Key
    public typealias SRight = Value
    
    public static func calculateSize<D: SkippableDecoder>(
        in decoder: inout D,
        lsize: @escaping (inout D) throws -> Int,
        rsize: @escaping (inout D) throws -> Int
    ) throws -> Int {
        try Array<(DLeft, DRight)>.calculateSize(in: &decoder) {
            try lsize(&$0) + rsize(&$0)
        }
    }
}

extension Dictionary: ContainerSizeCalculable where Key: SizeCalculable {
    public typealias SElement = Value
}

extension Dictionary: SizeCalculable where Key: SizeCalculable, Value: SizeCalculable {}
