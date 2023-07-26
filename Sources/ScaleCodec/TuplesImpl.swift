//
// Generated '2023-07-26 15:15:26 +0000' with 'generate_tuples.swift'
//
import Foundation
@_exported import Tuples

//================ Tuple0 ==================
extension Tuple0: Decodable  {}
extension Tuple0: Encodable  {}
extension Tuple0: SizeCalculable  {}
public extension Decoder {
    @inlinable
    mutating func decode(_ t: ().Type) throws -> () {
        try self.decode(VoidTuple.self).tuple
    }
    @inlinable
    mutating func decode() throws -> () {
        try self.decode(VoidTuple.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode(_ value: ()) throws {
        try self.encode(VoidTuple(value))
    }
}
@inlinable
public func encode(
    _ value: (),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data {
    try encode(VoidTuple(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode(_ t: ().Type, from data: Data) throws -> () {
    try decode(from: data)
}
@inlinable
public func decode(from data: Data) throws -> () {
    try decode(VoidTuple.self, from: data).tuple
}
//============== end of Tuple0 =============

//================ Tuple1 ==================
extension Tuple1: Decodable
    where
        T1: Decodable {}
extension Tuple1: Encodable
    where
        T1: Encodable {}
extension Tuple1: SizeCalculable
    where
        T1: SizeCalculable {}

//============== end of Tuple1 =============

//================ Tuple2 ==================
extension Tuple2: Decodable
    where
        T1: Decodable, T2: Decodable {}
extension Tuple2: Encodable
    where
        T1: Encodable, T2: Encodable {}
extension Tuple2: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2>(_ t: (T1, T2).Type) throws -> (T1, T2)
        where
            T1: Decodable, T2: Decodable
    {
        try self.decode(Tuple2<T1, T2>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2>() throws -> (T1, T2)
        where
            T1: Decodable, T2: Decodable
    {
        try self.decode(Tuple2<T1, T2>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2>(_ value: (T1, T2)) throws
        where
            T1: Encodable, T2: Encodable
    {
        try self.encode(Tuple2(value))
    }
}
@inlinable
public func encode<T1, T2>(
    _ value: (T1, T2),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable
{
    try encode(Tuple2(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2>(_ t: (T1, T2).Type, from data: Data) throws -> (T1, T2)
    where
        T1: Decodable, T2: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2>(from data: Data) throws -> (T1, T2)
    where
        T1: Decodable, T2: Decodable
{
    try decode(Tuple2<T1, T2>.self, from: data).tuple
}
//============== end of Tuple2 =============

//================ Tuple3 ==================
extension Tuple3: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable {}
extension Tuple3: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable {}
extension Tuple3: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3>(_ t: (T1, T2, T3).Type) throws -> (T1, T2, T3)
        where
            T1: Decodable, T2: Decodable, T3: Decodable
    {
        try self.decode(Tuple3<T1, T2, T3>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3>() throws -> (T1, T2, T3)
        where
            T1: Decodable, T2: Decodable, T3: Decodable
    {
        try self.decode(Tuple3<T1, T2, T3>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3>(_ value: (T1, T2, T3)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable
    {
        try self.encode(Tuple3(value))
    }
}
@inlinable
public func encode<T1, T2, T3>(
    _ value: (T1, T2, T3),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable
{
    try encode(Tuple3(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3>(_ t: (T1, T2, T3).Type, from data: Data) throws -> (T1, T2, T3)
    where
        T1: Decodable, T2: Decodable, T3: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3>(from data: Data) throws -> (T1, T2, T3)
    where
        T1: Decodable, T2: Decodable, T3: Decodable
{
    try decode(Tuple3<T1, T2, T3>.self, from: data).tuple
}
//============== end of Tuple3 =============

//================ Tuple4 ==================
extension Tuple4: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable {}
extension Tuple4: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable {}
extension Tuple4: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4>(_ t: (T1, T2, T3, T4).Type) throws -> (T1, T2, T3, T4)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable
    {
        try self.decode(Tuple4<T1, T2, T3, T4>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4>() throws -> (T1, T2, T3, T4)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable
    {
        try self.decode(Tuple4<T1, T2, T3, T4>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4>(_ value: (T1, T2, T3, T4)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable
    {
        try self.encode(Tuple4(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4>(
    _ value: (T1, T2, T3, T4),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable
{
    try encode(Tuple4(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4>(_ t: (T1, T2, T3, T4).Type, from data: Data) throws -> (T1, T2, T3, T4)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4>(from data: Data) throws -> (T1, T2, T3, T4)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable
{
    try decode(Tuple4<T1, T2, T3, T4>.self, from: data).tuple
}
//============== end of Tuple4 =============

//================ Tuple5 ==================
extension Tuple5: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable {}
extension Tuple5: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable {}
extension Tuple5: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5>(_ t: (T1, T2, T3, T4, T5).Type) throws -> (T1, T2, T3, T4, T5)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable
    {
        try self.decode(Tuple5<T1, T2, T3, T4, T5>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5>() throws -> (T1, T2, T3, T4, T5)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable
    {
        try self.decode(Tuple5<T1, T2, T3, T4, T5>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5>(_ value: (T1, T2, T3, T4, T5)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable
    {
        try self.encode(Tuple5(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5>(
    _ value: (T1, T2, T3, T4, T5),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable
{
    try encode(Tuple5(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5>(_ t: (T1, T2, T3, T4, T5).Type, from data: Data) throws -> (T1, T2, T3, T4, T5)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5>(from data: Data) throws -> (T1, T2, T3, T4, T5)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable
{
    try decode(Tuple5<T1, T2, T3, T4, T5>.self, from: data).tuple
}
//============== end of Tuple5 =============

//================ Tuple6 ==================
extension Tuple6: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable {}
extension Tuple6: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable {}
extension Tuple6: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6>(_ t: (T1, T2, T3, T4, T5, T6).Type) throws -> (T1, T2, T3, T4, T5, T6)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable
    {
        try self.decode(Tuple6<T1, T2, T3, T4, T5, T6>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6>() throws -> (T1, T2, T3, T4, T5, T6)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable
    {
        try self.decode(Tuple6<T1, T2, T3, T4, T5, T6>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5, T6>(_ value: (T1, T2, T3, T4, T5, T6)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable
    {
        try self.encode(Tuple6(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5, T6>(
    _ value: (T1, T2, T3, T4, T5, T6),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable
{
    try encode(Tuple6(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6>(_ t: (T1, T2, T3, T4, T5, T6).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable
{
    try decode(Tuple6<T1, T2, T3, T4, T5, T6>.self, from: data).tuple
}
//============== end of Tuple6 =============

//================ Tuple7 ==================
extension Tuple7: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable {}
extension Tuple7: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable {}
extension Tuple7: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7>(_ t: (T1, T2, T3, T4, T5, T6, T7).Type) throws -> (T1, T2, T3, T4, T5, T6, T7)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable
    {
        try self.decode(Tuple7<T1, T2, T3, T4, T5, T6, T7>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7>() throws -> (T1, T2, T3, T4, T5, T6, T7)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable
    {
        try self.decode(Tuple7<T1, T2, T3, T4, T5, T6, T7>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5, T6, T7>(_ value: (T1, T2, T3, T4, T5, T6, T7)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable
    {
        try self.encode(Tuple7(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5, T6, T7>(
    _ value: (T1, T2, T3, T4, T5, T6, T7),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable
{
    try encode(Tuple7(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7>(_ t: (T1, T2, T3, T4, T5, T6, T7).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable
{
    try decode(Tuple7<T1, T2, T3, T4, T5, T6, T7>.self, from: data).tuple
}
//============== end of Tuple7 =============

//================ Tuple8 ==================
extension Tuple8: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable {}
extension Tuple8: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable {}
extension Tuple8: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable
    {
        try self.decode(Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable
    {
        try self.decode(Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable
    {
        try self.encode(Tuple8(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5, T6, T7, T8>(
    _ value: (T1, T2, T3, T4, T5, T6, T7, T8),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable
{
    try encode(Tuple8(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable
{
    try decode(Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>.self, from: data).tuple
}
//============== end of Tuple8 =============

//================ Tuple9 ==================
extension Tuple9: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable {}
extension Tuple9: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable {}
extension Tuple9: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable,
        T9: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable
    {
        try self.decode(Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable
    {
        try self.decode(Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
            T9: Encodable
    {
        try self.encode(Tuple9(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(
    _ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable
{
    try encode(Tuple9(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable
{
    try decode(Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>.self, from: data).tuple
}
//============== end of Tuple9 =============

//================ Tuple10 ==================
extension Tuple10: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable {}
extension Tuple10: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable {}
extension Tuple10: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable,
        T9: SizeCalculable, T10: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable
    {
        try self.decode(Tuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable
    {
        try self.decode(Tuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
            T9: Encodable, T10: Encodable
    {
        try self.encode(Tuple10(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(
    _ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable
{
    try encode(Tuple10(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable
{
    try decode(Tuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>.self, from: data).tuple
}
//============== end of Tuple10 =============

//================ Tuple11 ==================
extension Tuple11: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable {}
extension Tuple11: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable, T11: Encodable {}
extension Tuple11: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable,
        T9: SizeCalculable, T10: SizeCalculable, T11: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable, T11: Decodable
    {
        try self.decode(Tuple11<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable, T11: Decodable
    {
        try self.decode(Tuple11<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
            T9: Encodable, T10: Encodable, T11: Encodable
    {
        try self.encode(Tuple11(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(
    _ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable, T11: Encodable
{
    try encode(Tuple11(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable
{
    try decode(Tuple11<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11>.self, from: data).tuple
}
//============== end of Tuple11 =============

//================ Tuple12 ==================
extension Tuple12: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable {}
extension Tuple12: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable {}
extension Tuple12: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable,
        T9: SizeCalculable, T10: SizeCalculable, T11: SizeCalculable, T12: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable
    {
        try self.decode(Tuple12<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable
    {
        try self.decode(Tuple12<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
            T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable
    {
        try self.encode(Tuple12(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(
    _ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable
{
    try encode(Tuple12(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable
{
    try decode(Tuple12<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12>.self, from: data).tuple
}
//============== end of Tuple12 =============

//================ Tuple13 ==================
extension Tuple13: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
        T13: Decodable {}
extension Tuple13: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable,
        T13: Encodable {}
extension Tuple13: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable,
        T9: SizeCalculable, T10: SizeCalculable, T11: SizeCalculable, T12: SizeCalculable,
        T13: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
            T13: Decodable
    {
        try self.decode(Tuple13<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
            T13: Decodable
    {
        try self.decode(Tuple13<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
            T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable,
            T13: Encodable
    {
        try self.encode(Tuple13(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(
    _ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable,
        T13: Encodable
{
    try encode(Tuple13(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
        T13: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
        T13: Decodable
{
    try decode(Tuple13<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13>.self, from: data).tuple
}
//============== end of Tuple13 =============

//================ Tuple14 ==================
extension Tuple14: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
        T13: Decodable, T14: Decodable {}
extension Tuple14: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable,
        T13: Encodable, T14: Encodable {}
extension Tuple14: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable,
        T9: SizeCalculable, T10: SizeCalculable, T11: SizeCalculable, T12: SizeCalculable,
        T13: SizeCalculable, T14: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
            T13: Decodable, T14: Decodable
    {
        try self.decode(Tuple14<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
            T13: Decodable, T14: Decodable
    {
        try self.decode(Tuple14<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
            T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable,
            T13: Encodable, T14: Encodable
    {
        try self.encode(Tuple14(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(
    _ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable,
        T13: Encodable, T14: Encodable
{
    try encode(Tuple14(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
        T13: Decodable, T14: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
        T13: Decodable, T14: Decodable
{
    try decode(Tuple14<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14>.self, from: data).tuple
}
//============== end of Tuple14 =============

//================ Tuple15 ==================
extension Tuple15: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
        T13: Decodable, T14: Decodable, T15: Decodable {}
extension Tuple15: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable,
        T13: Encodable, T14: Encodable, T15: Encodable {}
extension Tuple15: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable,
        T9: SizeCalculable, T10: SizeCalculable, T11: SizeCalculable, T12: SizeCalculable,
        T13: SizeCalculable, T14: SizeCalculable, T15: SizeCalculable {}
public extension Decoder {
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
            T13: Decodable, T14: Decodable, T15: Decodable
    {
        try self.decode(Tuple15<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>.self).tuple
    }
    @inlinable
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
            T13: Decodable, T14: Decodable, T15: Decodable
    {
        try self.decode(Tuple15<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>.self).tuple
    }
}
public extension Encoder {
    @inlinable
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
            T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable,
            T13: Encodable, T14: Encodable, T15: Encodable
    {
        try self.encode(Tuple15(value))
    }
}
@inlinable
public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(
    _ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15),
    reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable, T11: Encodable, T12: Encodable,
        T13: Encodable, T14: Encodable, T15: Encodable
{
    try encode(Tuple15(value), reservedCapacity: reservedCapacity)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
        T13: Decodable, T14: Decodable, T15: Decodable
{
    try decode(from: data)
}
@inlinable
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable, T11: Decodable, T12: Decodable,
        T13: Decodable, T14: Decodable, T15: Decodable
{
    try decode(Tuple15<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10, T11, T12, T13, T14, T15>.self, from: data).tuple
}
//============== end of Tuple15 =============
