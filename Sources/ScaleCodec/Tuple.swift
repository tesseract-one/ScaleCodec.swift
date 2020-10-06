//
// Generated '2020-10-06 18:49:14 +0000' with 'generate_tuples.swift'
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

public func STuple<T1, T2>(_ t: (T1, T2)) -> STuple2<T1, T2> {
    return STuple2(t)
}

extension STuple2: ScaleEncodable
    where
        T1: ScaleEncodable, T2: ScaleEncodable
{
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(_0).encode(_1)
    }
}

extension STuple2: ScaleDecodable
    where
        T1: ScaleDecodable, T2: ScaleDecodable
{
    public init(from decoder: ScaleDecoder) throws {
        try self.init(
            decoder.decode(), decoder.decode()
        )
    }
}

extension ScaleDecoder {
    public func decode<T1, T2>(_ t: (T1, T2).Type) throws -> (T1, T2)
        where
            T1: ScaleDecodable, T2: ScaleDecodable
    {
        return try self.decode(STuple2<T1, T2>.self).tuple
    }

    public func decode<T1, T2>() throws -> (T1, T2)
        where
            T1: ScaleDecodable, T2: ScaleDecodable
    {
        return try self.decode(STuple2<T1, T2>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1, T2>(_ value: (T1, T2)) throws -> ScaleEncoder
        where
            T1: ScaleEncodable, T2: ScaleEncodable
    {
        try self.encode(STuple(value))
    }
}

extension SCALE {
    public func encode<T1, T2>(_ value: (T1, T2)) throws -> Data
        where
            T1: ScaleEncodable, T2: ScaleEncodable
    {
        return try self.encode(STuple(value))
    }

    public func decode<T1, T2>(_ t: (T1, T2).Type, from data: Data) throws -> (T1, T2)
        where
            T1: ScaleDecodable, T2: ScaleDecodable
    {
        return try self.decode(from: data)
    }

    public func decode<T1, T2>(from data: Data) throws -> (T1, T2)
        where
            T1: ScaleDecodable, T2: ScaleDecodable
    {
        return try self.decode(STuple2<T1, T2>.self, from: data).tuple
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

public func STuple<T1, T2, T3>(_ t: (T1, T2, T3)) -> STuple3<T1, T2, T3> {
    return STuple3(t)
}

extension STuple3: ScaleEncodable
    where
        T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable
{
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(_0).encode(_1).encode(_2)
    }
}

extension STuple3: ScaleDecodable
    where
        T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable
{
    public init(from decoder: ScaleDecoder) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode()
        )
    }
}

extension ScaleDecoder {
    public func decode<T1, T2, T3>(_ t: (T1, T2, T3).Type) throws -> (T1, T2, T3)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable
    {
        return try self.decode(STuple3<T1, T2, T3>.self).tuple
    }

    public func decode<T1, T2, T3>() throws -> (T1, T2, T3)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable
    {
        return try self.decode(STuple3<T1, T2, T3>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1, T2, T3>(_ value: (T1, T2, T3)) throws -> ScaleEncoder
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable
    {
        try self.encode(STuple(value))
    }
}

extension SCALE {
    public func encode<T1, T2, T3>(_ value: (T1, T2, T3)) throws -> Data
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable
    {
        return try self.encode(STuple(value))
    }

    public func decode<T1, T2, T3>(_ t: (T1, T2, T3).Type, from data: Data) throws -> (T1, T2, T3)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable
    {
        return try self.decode(from: data)
    }

    public func decode<T1, T2, T3>(from data: Data) throws -> (T1, T2, T3)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable
    {
        return try self.decode(STuple3<T1, T2, T3>.self, from: data).tuple
    }
}

 public struct STuple4<T1, T2, T3, T4> {
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4

    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4
    }

    public init(_ t: (T1, T2, T3, T4)) {
        self.init(t.0, t.1, t.2, t.3)
    }

    public var tuple: (T1, T2, T3, T4) {
        return (_0, _1, _2, _3)
    }
}

public func STuple<T1, T2, T3, T4>(_ t: (T1, T2, T3, T4)) -> STuple4<T1, T2, T3, T4> {
    return STuple4(t)
}

extension STuple4: ScaleEncodable
    where
        T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable
{
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(_0).encode(_1).encode(_2).encode(_3)
    }
}

extension STuple4: ScaleDecodable
    where
        T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable
{
    public init(from decoder: ScaleDecoder) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode()
        )
    }
}

extension ScaleDecoder {
    public func decode<T1, T2, T3, T4>(_ t: (T1, T2, T3, T4).Type) throws -> (T1, T2, T3, T4)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable
    {
        return try self.decode(STuple4<T1, T2, T3, T4>.self).tuple
    }

    public func decode<T1, T2, T3, T4>() throws -> (T1, T2, T3, T4)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable
    {
        return try self.decode(STuple4<T1, T2, T3, T4>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1, T2, T3, T4>(_ value: (T1, T2, T3, T4)) throws -> ScaleEncoder
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable
    {
        try self.encode(STuple(value))
    }
}

extension SCALE {
    public func encode<T1, T2, T3, T4>(_ value: (T1, T2, T3, T4)) throws -> Data
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable
    {
        return try self.encode(STuple(value))
    }

    public func decode<T1, T2, T3, T4>(_ t: (T1, T2, T3, T4).Type, from data: Data) throws -> (T1, T2, T3, T4)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable
    {
        return try self.decode(from: data)
    }

    public func decode<T1, T2, T3, T4>(from data: Data) throws -> (T1, T2, T3, T4)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable
    {
        return try self.decode(STuple4<T1, T2, T3, T4>.self, from: data).tuple
    }
}

 public struct STuple5<T1, T2, T3, T4, T5> {
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5

    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5
    }

    public init(_ t: (T1, T2, T3, T4, T5)) {
        self.init(t.0, t.1, t.2, t.3, t.4)
    }

    public var tuple: (T1, T2, T3, T4, T5) {
        return (_0, _1, _2, _3, _4)
    }
}

public func STuple<T1, T2, T3, T4, T5>(_ t: (T1, T2, T3, T4, T5)) -> STuple5<T1, T2, T3, T4, T5> {
    return STuple5(t)
}

extension STuple5: ScaleEncodable
    where
        T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
        T5: ScaleEncodable
{
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(_0).encode(_1).encode(_2).encode(_3).encode(_4)
    }
}

extension STuple5: ScaleDecodable
    where
        T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
        T5: ScaleDecodable
{
    public init(from decoder: ScaleDecoder) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode()
        )
    }
}

extension ScaleDecoder {
    public func decode<T1, T2, T3, T4, T5>(_ t: (T1, T2, T3, T4, T5).Type) throws -> (T1, T2, T3, T4, T5)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable
    {
        return try self.decode(STuple5<T1, T2, T3, T4, T5>.self).tuple
    }

    public func decode<T1, T2, T3, T4, T5>() throws -> (T1, T2, T3, T4, T5)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable
    {
        return try self.decode(STuple5<T1, T2, T3, T4, T5>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1, T2, T3, T4, T5>(_ value: (T1, T2, T3, T4, T5)) throws -> ScaleEncoder
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable
    {
        try self.encode(STuple(value))
    }
}

extension SCALE {
    public func encode<T1, T2, T3, T4, T5>(_ value: (T1, T2, T3, T4, T5)) throws -> Data
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable
    {
        return try self.encode(STuple(value))
    }

    public func decode<T1, T2, T3, T4, T5>(_ t: (T1, T2, T3, T4, T5).Type, from data: Data) throws -> (T1, T2, T3, T4, T5)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable
    {
        return try self.decode(from: data)
    }

    public func decode<T1, T2, T3, T4, T5>(from data: Data) throws -> (T1, T2, T3, T4, T5)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable
    {
        return try self.decode(STuple5<T1, T2, T3, T4, T5>.self, from: data).tuple
    }
}

 public struct STuple6<T1, T2, T3, T4, T5, T6> {
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5
    public let _5: T6

    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5, _ v6: T6) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5; _5 = v6
    }

    public init(_ t: (T1, T2, T3, T4, T5, T6)) {
        self.init(t.0, t.1, t.2, t.3, t.4, t.5)
    }

    public var tuple: (T1, T2, T3, T4, T5, T6) {
        return (_0, _1, _2, _3, _4, _5)
    }
}

public func STuple<T1, T2, T3, T4, T5, T6>(_ t: (T1, T2, T3, T4, T5, T6)) -> STuple6<T1, T2, T3, T4, T5, T6> {
    return STuple6(t)
}

extension STuple6: ScaleEncodable
    where
        T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
        T5: ScaleEncodable, T6: ScaleEncodable
{
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(_0).encode(_1).encode(_2).encode(_3).encode(_4)
            .encode(_5)
    }
}

extension STuple6: ScaleDecodable
    where
        T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
        T5: ScaleDecodable, T6: ScaleDecodable
{
    public init(from decoder: ScaleDecoder) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode()
        )
    }
}

extension ScaleDecoder {
    public func decode<T1, T2, T3, T4, T5, T6>(_ t: (T1, T2, T3, T4, T5, T6).Type) throws -> (T1, T2, T3, T4, T5, T6)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable
    {
        return try self.decode(STuple6<T1, T2, T3, T4, T5, T6>.self).tuple
    }

    public func decode<T1, T2, T3, T4, T5, T6>() throws -> (T1, T2, T3, T4, T5, T6)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable
    {
        return try self.decode(STuple6<T1, T2, T3, T4, T5, T6>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1, T2, T3, T4, T5, T6>(_ value: (T1, T2, T3, T4, T5, T6)) throws -> ScaleEncoder
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable, T6: ScaleEncodable
    {
        try self.encode(STuple(value))
    }
}

extension SCALE {
    public func encode<T1, T2, T3, T4, T5, T6>(_ value: (T1, T2, T3, T4, T5, T6)) throws -> Data
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable, T6: ScaleEncodable
    {
        return try self.encode(STuple(value))
    }

    public func decode<T1, T2, T3, T4, T5, T6>(_ t: (T1, T2, T3, T4, T5, T6).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable
    {
        return try self.decode(from: data)
    }

    public func decode<T1, T2, T3, T4, T5, T6>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable
    {
        return try self.decode(STuple6<T1, T2, T3, T4, T5, T6>.self, from: data).tuple
    }
}

 public struct STuple7<T1, T2, T3, T4, T5, T6, T7> {
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5
    public let _5: T6
    public let _6: T7

    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5, _ v6: T6, _ v7: T7) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5; _5 = v6
        _6 = v7
    }

    public init(_ t: (T1, T2, T3, T4, T5, T6, T7)) {
        self.init(t.0, t.1, t.2, t.3, t.4, t.5, t.6)
    }

    public var tuple: (T1, T2, T3, T4, T5, T6, T7) {
        return (_0, _1, _2, _3, _4, _5, _6)
    }
}

public func STuple<T1, T2, T3, T4, T5, T6, T7>(_ t: (T1, T2, T3, T4, T5, T6, T7)) -> STuple7<T1, T2, T3, T4, T5, T6, T7> {
    return STuple7(t)
}

extension STuple7: ScaleEncodable
    where
        T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
        T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable
{
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(_0).encode(_1).encode(_2).encode(_3).encode(_4)
            .encode(_5).encode(_6)
    }
}

extension STuple7: ScaleDecodable
    where
        T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
        T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable
{
    public init(from decoder: ScaleDecoder) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode()
        )
    }
}

extension ScaleDecoder {
    public func decode<T1, T2, T3, T4, T5, T6, T7>(_ t: (T1, T2, T3, T4, T5, T6, T7).Type) throws -> (T1, T2, T3, T4, T5, T6, T7)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable
    {
        return try self.decode(STuple7<T1, T2, T3, T4, T5, T6, T7>.self).tuple
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7>() throws -> (T1, T2, T3, T4, T5, T6, T7)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable
    {
        return try self.decode(STuple7<T1, T2, T3, T4, T5, T6, T7>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1, T2, T3, T4, T5, T6, T7>(_ value: (T1, T2, T3, T4, T5, T6, T7)) throws -> ScaleEncoder
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable
    {
        try self.encode(STuple(value))
    }
}

extension SCALE {
    public func encode<T1, T2, T3, T4, T5, T6, T7>(_ value: (T1, T2, T3, T4, T5, T6, T7)) throws -> Data
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable
    {
        return try self.encode(STuple(value))
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7>(_ t: (T1, T2, T3, T4, T5, T6, T7).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable
    {
        return try self.decode(from: data)
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable
    {
        return try self.decode(STuple7<T1, T2, T3, T4, T5, T6, T7>.self, from: data).tuple
    }
}

 public struct STuple8<T1, T2, T3, T4, T5, T6, T7, T8> {
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5
    public let _5: T6
    public let _6: T7
    public let _7: T8

    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5, _ v6: T6, _ v7: T7, _ v8: T8) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5; _5 = v6
        _6 = v7; _7 = v8
    }

    public init(_ t: (T1, T2, T3, T4, T5, T6, T7, T8)) {
        self.init(t.0, t.1, t.2, t.3, t.4, t.5, t.6, t.7)
    }

    public var tuple: (T1, T2, T3, T4, T5, T6, T7, T8) {
        return (_0, _1, _2, _3, _4, _5, _6, _7)
    }
}

public func STuple<T1, T2, T3, T4, T5, T6, T7, T8>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8)) -> STuple8<T1, T2, T3, T4, T5, T6, T7, T8> {
    return STuple8(t)
}

extension STuple8: ScaleEncodable
    where
        T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
        T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable, T8: ScaleEncodable
{
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(_0).encode(_1).encode(_2).encode(_3).encode(_4)
            .encode(_5).encode(_6).encode(_7)
    }
}

extension STuple8: ScaleDecodable
    where
        T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
        T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable
{
    public init(from decoder: ScaleDecoder) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode()
        )
    }
}

extension ScaleDecoder {
    public func decode<T1, T2, T3, T4, T5, T6, T7, T8>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable
    {
        return try self.decode(STuple8<T1, T2, T3, T4, T5, T6, T7, T8>.self).tuple
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7, T8>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable
    {
        return try self.decode(STuple8<T1, T2, T3, T4, T5, T6, T7, T8>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1, T2, T3, T4, T5, T6, T7, T8>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8)) throws -> ScaleEncoder
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable, T8: ScaleEncodable
    {
        try self.encode(STuple(value))
    }
}

extension SCALE {
    public func encode<T1, T2, T3, T4, T5, T6, T7, T8>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8)) throws -> Data
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable, T8: ScaleEncodable
    {
        return try self.encode(STuple(value))
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7, T8>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable
    {
        return try self.decode(from: data)
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7, T8>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable
    {
        return try self.decode(STuple8<T1, T2, T3, T4, T5, T6, T7, T8>.self, from: data).tuple
    }
}

 public struct STuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9> {
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5
    public let _5: T6
    public let _6: T7
    public let _7: T8
    public let _8: T9

    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5, _ v6: T6, _ v7: T7, _ v8: T8, _ v9: T9) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5; _5 = v6
        _6 = v7; _7 = v8; _8 = v9
    }

    public init(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9)) {
        self.init(t.0, t.1, t.2, t.3, t.4, t.5, t.6, t.7, t.8)
    }

    public var tuple: (T1, T2, T3, T4, T5, T6, T7, T8, T9) {
        return (_0, _1, _2, _3, _4, _5, _6, _7, _8)
    }
}

public func STuple<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9)) -> STuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9> {
    return STuple9(t)
}

extension STuple9: ScaleEncodable
    where
        T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
        T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable, T8: ScaleEncodable,
        T9: ScaleEncodable
{
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(_0).encode(_1).encode(_2).encode(_3).encode(_4)
            .encode(_5).encode(_6).encode(_7).encode(_8)
    }
}

extension STuple9: ScaleDecodable
    where
        T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
        T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable,
        T9: ScaleDecodable
{
    public init(from decoder: ScaleDecoder) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode()
        )
    }
}

extension ScaleDecoder {
    public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable,
            T9: ScaleDecodable
    {
        return try self.decode(STuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>.self).tuple
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable,
            T9: ScaleDecodable
    {
        return try self.decode(STuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9)) throws -> ScaleEncoder
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable, T8: ScaleEncodable,
            T9: ScaleEncodable
    {
        try self.encode(STuple(value))
    }
}

extension SCALE {
    public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9)) throws -> Data
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable, T8: ScaleEncodable,
            T9: ScaleEncodable
    {
        return try self.encode(STuple(value))
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable,
            T9: ScaleDecodable
    {
        return try self.decode(from: data)
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable,
            T9: ScaleDecodable
    {
        return try self.decode(STuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>.self, from: data).tuple
    }
}

 public struct STuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> {
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5
    public let _5: T6
    public let _6: T7
    public let _7: T8
    public let _8: T9
    public let _9: T10

    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5, _ v6: T6, _ v7: T7, _ v8: T8, _ v9: T9, _ v10: T10) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5; _5 = v6
        _6 = v7; _7 = v8; _8 = v9; _9 = v10
    }

    public init(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)) {
        self.init(t.0, t.1, t.2, t.3, t.4, t.5, t.6, t.7, t.8, t.9)
    }

    public var tuple: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10) {
        return (_0, _1, _2, _3, _4, _5, _6, _7, _8, _9)
    }
}

public func STuple<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)) -> STuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> {
    return STuple10(t)
}

extension STuple10: ScaleEncodable
    where
        T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
        T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable, T8: ScaleEncodable,
        T9: ScaleEncodable, T10: ScaleEncodable
{
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(_0).encode(_1).encode(_2).encode(_3).encode(_4)
            .encode(_5).encode(_6).encode(_7).encode(_8).encode(_9)
    }
}

extension STuple10: ScaleDecodable
    where
        T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
        T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable,
        T9: ScaleDecodable, T10: ScaleDecodable
{
    public init(from decoder: ScaleDecoder) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode()
        )
    }
}

extension ScaleDecoder {
    public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable,
            T9: ScaleDecodable, T10: ScaleDecodable
    {
        return try self.decode(STuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>.self).tuple
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable,
            T9: ScaleDecodable, T10: ScaleDecodable
    {
        return try self.decode(STuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>.self).tuple
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)) throws -> ScaleEncoder
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable, T8: ScaleEncodable,
            T9: ScaleEncodable, T10: ScaleEncodable
    {
        try self.encode(STuple(value))
    }
}

extension SCALE {
    public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)) throws -> Data
        where
            T1: ScaleEncodable, T2: ScaleEncodable, T3: ScaleEncodable, T4: ScaleEncodable,
            T5: ScaleEncodable, T6: ScaleEncodable, T7: ScaleEncodable, T8: ScaleEncodable,
            T9: ScaleEncodable, T10: ScaleEncodable
    {
        return try self.encode(STuple(value))
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable,
            T9: ScaleDecodable, T10: ScaleDecodable
    {
        return try self.decode(from: data)
    }

    public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
        where
            T1: ScaleDecodable, T2: ScaleDecodable, T3: ScaleDecodable, T4: ScaleDecodable,
            T5: ScaleDecodable, T6: ScaleDecodable, T7: ScaleDecodable, T8: ScaleDecodable,
            T9: ScaleDecodable, T10: ScaleDecodable
    {
        return try self.decode(STuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>.self, from: data).tuple
    }
}
