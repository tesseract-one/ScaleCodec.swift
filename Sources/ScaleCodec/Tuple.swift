//
//  Tuple.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

public struct STuple2<T1, T2> {
    public let _0: T1
    public let _1: T2
    
    public init(_ v1: T1, _ v2: T2) {
        _0 = v1; _1 = v2
    }
    
    public init(_ t: (T1, T2)) {
        self.init(t.0, t.1)
    }
    
    public var tuple: (T1, T2) {
        return (_0, _1)
    }
}

extension STuple2: ScaleEncodable where T1: ScaleEncodable, T2: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(_0).encode(_1)
    }
}

extension STuple2: ScaleDecodable where T1: ScaleDecodable, T2: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        try self.init(decoder.decode(), decoder.decode())
    }
}

extension ScaleDecoder {
    public func decode<T1: ScaleDecodable, T2: ScaleDecodable>(_ t: (T1, T2).Type) throws -> (T1, T2) {
        return try self.decode(STuple2<T1, T2>.self).tuple
    }
    
    public func decode<T1: ScaleDecodable, T2: ScaleDecodable>() throws -> (T1, T2) {
        return try self.decode(STuple2<T1, T2>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1: ScaleEncodable, T2: ScaleEncodable>(_ value: (T1, T2)) throws -> ScaleEncoder {
        return try self.encode(STuple(value))
    }
}

public struct STuple3<T1, T2, T3> {
    public let _0: T1
    public let _1: T2
    public let _2: T3
    
    public init(_ v1: T1, _ v2: T2, _ v3: T3) {
        _0 = v1; _1 = v2; _2 = v3
    }
    
    public init(_ t: (T1, T2, T3)) {
        self.init(t.0, t.1, t.2)
    }
    
    public var tuple: (T1, T2, T3) {
        return (_0, _1, _2)
    }
}

extension STuple3: ScaleEncodable
    where T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable
{
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(_0).encode(_1).encode(_2)
    }
}

extension STuple3: ScaleDecodable
    where T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable
{
    public init(from decoder: ScaleDecoder) throws {
        try self.init(decoder.decode(), decoder.decode(), decoder.decode())
    }
}

extension ScaleDecoder {
    public func decode<T1, T2, T3>(_ t: (T1, T2).Type) throws -> (T1, T2, T3)
        where T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable
    {
        return try self.decode(STuple3<T1, T2, T3>.self).tuple
    }
    public func decode<T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable>() throws -> (T1, T2, T3) {
        return try self.decode(STuple3<T1, T2, T3>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1, T2, T3>(_ value: (T1, T2, T3)) throws -> ScaleEncoder
        where T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable
    {
        return try self.encode(STuple(value))
    }
}

public func STuple<T1, T2>(_ t: (T1, T2)) -> STuple2<T1, T2> {
    return STuple2(t)
}

public func STuple<T1, T2, T3>(_ t: (T1, T2, T3)) -> STuple3<T1, T2, T3> {
    return STuple3(t)
}
