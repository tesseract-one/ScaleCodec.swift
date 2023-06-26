//
// Generated '2023-06-26 14:03:53 +0000' with 'generate_tuples.swift'
//
import Foundation

//================ Tuple0 ==================
public struct Tuple0: ATuple {
    public typealias STuple = ()

    @inlinable
    public init() { }
    @inlinable
    public init(_ t: STuple) {
        self.init()
    }
    @inlinable
    public var tuple: STuple {
        ()
    }
    @inlinable
    public static var count: Int { 0 }
}
public func Tuple(_ t: ()) -> Tuple0 {
    Tuple0(t)
}
extension Tuple0: Encodable {
    public func encode<E: Encoder>(in encoder: inout E) throws {

    }
}
extension Tuple0: Decodable {
    public init<D: Decoder>(from decoder: inout D) throws {
        self.init()
    }
}
extension Tuple0: SizeCalculable {
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        0
    }
}
public extension Decoder {
    mutating func decode(_ t: ().Type) throws -> () {
        try self.decode(Tuple0.self).tuple
    }
    mutating func decode() throws -> () {
        try self.decode(Tuple0.self).tuple
    }
}
public extension Encoder {
    mutating func encode(_ value: ()) throws {
        try self.encode(Tuple0(value))
    }
}
public func encode(_ value: (), reservedCapacity: Int = 4096) throws -> Data {
    try encode(Tuple0(value), reservedCapacity: reservedCapacity)
}
public func decode(_ t: ().Type, from data: Data) throws -> () {
    try decode(from: data)
}
public func decode(from data: Data) throws -> () {
    try decode(Tuple0.self, from: data).tuple
}
//============== end of Tuple0 =============

//================ Tuple1 ==================
public struct Tuple1<T1>: ATuple {
    public typealias STuple = (T1)
    public let _0: T1
    @inlinable
    public init(_ v1: T1) {
        _0 = v1
    }

    @inlinable
    public var tuple: STuple {
        (_0)
    }
    @inlinable
    public static var count: Int { 1 }
}
extension Tuple1: LinkedTuple {
    public typealias First = T1
    public typealias Last = T1
    public typealias DroppedFirst = Tuple0
    public typealias DroppedLast = Tuple0
    @inlinable
    public init(first: DroppedLast, last: Last) {
        self.init(last)
    }
    @inlinable
    public init(first: First, last: DroppedFirst) {
        self.init(first)
    }
    public var first: First { _0 }
    public var last: Last { _0 }
    public var dropLast: DroppedLast {
        Tuple0()
    }
    public var dropFirst: DroppedFirst {
        Tuple0()
    }
}
public func Tuple<T1>(_ t: (T1)) -> Tuple1<T1> {
    Tuple1(t)
}
extension Tuple1: Encodable
    where
        T1: Encodable
{
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(_0)
    }
}
extension Tuple1: Decodable
    where
        T1: Decodable
{
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(
            decoder.decode()
        )
    }
}
extension Tuple1: SizeCalculable
    where
        T1: SizeCalculable
{
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try T1.calculateSize(in: &decoder)
    }
}

//============== end of Tuple1 =============

//================ Tuple2 ==================
public struct Tuple2<T1, T2>: ATuple {
    public typealias STuple = (T1, T2)
    public let _0: T1
    public let _1: T2
    @inlinable
    public init(_ v1: T1, _ v2: T2) {
        _0 = v1; _1 = v2
    }
    @inlinable
    public init(_ t: STuple) {
        self.init(t.0, t.1)
    }
    @inlinable
    public var tuple: STuple {
        (_0, _1)
    }
    @inlinable
    public static var count: Int { 2 }
}
extension Tuple2: LinkedTuple {
    public typealias First = T1
    public typealias Last = T2
    public typealias DroppedFirst = Tuple1<T2>
    public typealias DroppedLast = Tuple1<T1>
    @inlinable
    public init(first: DroppedLast, last: Last) {
        self.init(first._0, last)
    }
    @inlinable
    public init(first: First, last: DroppedFirst) {
        self.init(first, last._0)
    }
    public var first: First { _0 }
    public var last: Last { _1 }
    public var dropLast: DroppedLast {
        Tuple1(_0)
    }
    public var dropFirst: DroppedFirst {
        Tuple1(_1)
    }
}
public func Tuple<T1, T2>(_ t: (T1, T2)) -> Tuple2<T1, T2> {
    Tuple2(t)
}
extension Tuple2: Encodable
    where
        T1: Encodable, T2: Encodable
{
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(_0); try encoder.encode(_1)
    }
}
extension Tuple2: Decodable
    where
        T1: Decodable, T2: Decodable
{
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(
            decoder.decode(), decoder.decode()
        )
    }
}
extension Tuple2: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable
{
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try T1.calculateSize(in: &decoder) + T2.calculateSize(in: &decoder)
    }
}
public extension Decoder {
    mutating func decode<T1, T2>(_ t: (T1, T2).Type) throws -> (T1, T2)
        where
            T1: Decodable, T2: Decodable
    {
        try self.decode(Tuple2<T1, T2>.self).tuple
    }
    mutating func decode<T1, T2>() throws -> (T1, T2)
        where
            T1: Decodable, T2: Decodable
    {
        try self.decode(Tuple2<T1, T2>.self).tuple
    }
}
public extension Encoder {
    mutating func encode<T1, T2>(_ value: (T1, T2)) throws
        where
            T1: Encodable, T2: Encodable
    {
        try self.encode(Tuple2(value))
    }
}
public func encode<T1, T2>(_ value: (T1, T2), reservedCapacity: Int = 4096) throws -> Data
    where
        T1: Encodable, T2: Encodable
{
    try encode(Tuple2(value), reservedCapacity: reservedCapacity)
}
public func decode<T1, T2>(_ t: (T1, T2).Type, from data: Data) throws -> (T1, T2)
    where
        T1: Decodable, T2: Decodable
{
    try decode(from: data)
}
public func decode<T1, T2>(from data: Data) throws -> (T1, T2)
    where
        T1: Decodable, T2: Decodable
{
    try decode(Tuple2<T1, T2>.self, from: data).tuple
}
//============== end of Tuple2 =============

//================ Tuple3 ==================
public struct Tuple3<T1, T2, T3>: ATuple {
    public typealias STuple = (T1, T2, T3)
    public let _0: T1
    public let _1: T2
    public let _2: T3
    @inlinable
    public init(_ v1: T1, _ v2: T2, _ v3: T3) {
        _0 = v1; _1 = v2; _2 = v3
    }
    @inlinable
    public init(_ t: STuple) {
        self.init(t.0, t.1, t.2)
    }
    @inlinable
    public var tuple: STuple {
        (_0, _1, _2)
    }
    @inlinable
    public static var count: Int { 3 }
}
extension Tuple3: LinkedTuple {
    public typealias First = T1
    public typealias Last = T3
    public typealias DroppedFirst = Tuple2<T2, T3>
    public typealias DroppedLast = Tuple2<T1, T2>
    @inlinable
    public init(first: DroppedLast, last: Last) {
        self.init(first._0, first._1, last)
    }
    @inlinable
    public init(first: First, last: DroppedFirst) {
        self.init(first, last._0, last._1)
    }
    public var first: First { _0 }
    public var last: Last { _2 }
    public var dropLast: DroppedLast {
        Tuple2(_0, _1)
    }
    public var dropFirst: DroppedFirst {
        Tuple2(_1, _2)
    }
}
public func Tuple<T1, T2, T3>(_ t: (T1, T2, T3)) -> Tuple3<T1, T2, T3> {
    Tuple3(t)
}
extension Tuple3: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable
{
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(_0); try encoder.encode(_1); try encoder.encode(_2)
    }
}
extension Tuple3: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable
{
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode()
        )
    }
}
extension Tuple3: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable
{
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try T1.calculateSize(in: &decoder) + T2.calculateSize(in: &decoder) + T3.calculateSize(in: &decoder)
    }
}
public extension Decoder {
    mutating func decode<T1, T2, T3>(_ t: (T1, T2, T3).Type) throws -> (T1, T2, T3)
        where
            T1: Decodable, T2: Decodable, T3: Decodable
    {
        try self.decode(Tuple3<T1, T2, T3>.self).tuple
    }
    mutating func decode<T1, T2, T3>() throws -> (T1, T2, T3)
        where
            T1: Decodable, T2: Decodable, T3: Decodable
    {
        try self.decode(Tuple3<T1, T2, T3>.self).tuple
    }
}
public extension Encoder {
    mutating func encode<T1, T2, T3>(_ value: (T1, T2, T3)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable
    {
        try self.encode(Tuple3(value))
    }
}
public func encode<T1, T2, T3>(_ value: (T1, T2, T3), reservedCapacity: Int = 4096) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable
{
    try encode(Tuple3(value), reservedCapacity: reservedCapacity)
}
public func decode<T1, T2, T3>(_ t: (T1, T2, T3).Type, from data: Data) throws -> (T1, T2, T3)
    where
        T1: Decodable, T2: Decodable, T3: Decodable
{
    try decode(from: data)
}
public func decode<T1, T2, T3>(from data: Data) throws -> (T1, T2, T3)
    where
        T1: Decodable, T2: Decodable, T3: Decodable
{
    try decode(Tuple3<T1, T2, T3>.self, from: data).tuple
}
//============== end of Tuple3 =============

//================ Tuple4 ==================
public struct Tuple4<T1, T2, T3, T4>: ATuple {
    public typealias STuple = (T1, T2, T3, T4)
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    @inlinable
    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4
    }
    @inlinable
    public init(_ t: STuple) {
        self.init(t.0, t.1, t.2, t.3)
    }
    @inlinable
    public var tuple: STuple {
        (_0, _1, _2, _3)
    }
    @inlinable
    public static var count: Int { 4 }
}
extension Tuple4: LinkedTuple {
    public typealias First = T1
    public typealias Last = T4
    public typealias DroppedFirst = Tuple3<T2, T3, T4>
    public typealias DroppedLast = Tuple3<T1, T2, T3>
    @inlinable
    public init(first: DroppedLast, last: Last) {
        self.init(first._0, first._1, first._2, last)
    }
    @inlinable
    public init(first: First, last: DroppedFirst) {
        self.init(first, last._0, last._1, last._2)
    }
    public var first: First { _0 }
    public var last: Last { _3 }
    public var dropLast: DroppedLast {
        Tuple3(_0, _1, _2)
    }
    public var dropFirst: DroppedFirst {
        Tuple3(_1, _2, _3)
    }
}
public func Tuple<T1, T2, T3, T4>(_ t: (T1, T2, T3, T4)) -> Tuple4<T1, T2, T3, T4> {
    Tuple4(t)
}
extension Tuple4: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable
{
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(_0); try encoder.encode(_1); try encoder.encode(_2)
        try encoder.encode(_3)
    }
}
extension Tuple4: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable
{
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode()
        )
    }
}
extension Tuple4: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable
{
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try T1.calculateSize(in: &decoder) + T2.calculateSize(in: &decoder) + T3.calculateSize(in: &decoder) +
        T4.calculateSize(in: &decoder)
    }
}
public extension Decoder {
    mutating func decode<T1, T2, T3, T4>(_ t: (T1, T2, T3, T4).Type) throws -> (T1, T2, T3, T4)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable
    {
        try self.decode(Tuple4<T1, T2, T3, T4>.self).tuple
    }
    mutating func decode<T1, T2, T3, T4>() throws -> (T1, T2, T3, T4)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable
    {
        try self.decode(Tuple4<T1, T2, T3, T4>.self).tuple
    }
}
public extension Encoder {
    mutating func encode<T1, T2, T3, T4>(_ value: (T1, T2, T3, T4)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable
    {
        try self.encode(Tuple4(value))
    }
}
public func encode<T1, T2, T3, T4>(_ value: (T1, T2, T3, T4), reservedCapacity: Int = 4096) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable
{
    try encode(Tuple4(value), reservedCapacity: reservedCapacity)
}
public func decode<T1, T2, T3, T4>(_ t: (T1, T2, T3, T4).Type, from data: Data) throws -> (T1, T2, T3, T4)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable
{
    try decode(from: data)
}
public func decode<T1, T2, T3, T4>(from data: Data) throws -> (T1, T2, T3, T4)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable
{
    try decode(Tuple4<T1, T2, T3, T4>.self, from: data).tuple
}
//============== end of Tuple4 =============

//================ Tuple5 ==================
public struct Tuple5<T1, T2, T3, T4, T5>: ATuple {
    public typealias STuple = (T1, T2, T3, T4, T5)
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5
    @inlinable
    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5
    }
    @inlinable
    public init(_ t: STuple) {
        self.init(t.0, t.1, t.2, t.3, t.4)
    }
    @inlinable
    public var tuple: STuple {
        (_0, _1, _2, _3, _4)
    }
    @inlinable
    public static var count: Int { 5 }
}
extension Tuple5: LinkedTuple {
    public typealias First = T1
    public typealias Last = T5
    public typealias DroppedFirst = Tuple4<T2, T3, T4, T5>
    public typealias DroppedLast = Tuple4<T1, T2, T3, T4>
    @inlinable
    public init(first: DroppedLast, last: Last) {
        self.init(first._0, first._1, first._2, first._3, last)
    }
    @inlinable
    public init(first: First, last: DroppedFirst) {
        self.init(first, last._0, last._1, last._2, last._3)
    }
    public var first: First { _0 }
    public var last: Last { _4 }
    public var dropLast: DroppedLast {
        Tuple4(_0, _1, _2, _3)
    }
    public var dropFirst: DroppedFirst {
        Tuple4(_1, _2, _3, _4)
    }
}
public func Tuple<T1, T2, T3, T4, T5>(_ t: (T1, T2, T3, T4, T5)) -> Tuple5<T1, T2, T3, T4, T5> {
    Tuple5(t)
}
extension Tuple5: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable
{
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(_0); try encoder.encode(_1); try encoder.encode(_2)
        try encoder.encode(_3); try encoder.encode(_4)
    }
}
extension Tuple5: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable
{
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode()
        )
    }
}
extension Tuple5: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable
{
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try T1.calculateSize(in: &decoder) + T2.calculateSize(in: &decoder) + T3.calculateSize(in: &decoder) +
        T4.calculateSize(in: &decoder) + T5.calculateSize(in: &decoder)
    }
}
public extension Decoder {
    mutating func decode<T1, T2, T3, T4, T5>(_ t: (T1, T2, T3, T4, T5).Type) throws -> (T1, T2, T3, T4, T5)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable
    {
        try self.decode(Tuple5<T1, T2, T3, T4, T5>.self).tuple
    }
    mutating func decode<T1, T2, T3, T4, T5>() throws -> (T1, T2, T3, T4, T5)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable
    {
        try self.decode(Tuple5<T1, T2, T3, T4, T5>.self).tuple
    }
}
public extension Encoder {
    mutating func encode<T1, T2, T3, T4, T5>(_ value: (T1, T2, T3, T4, T5)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable
    {
        try self.encode(Tuple5(value))
    }
}
public func encode<T1, T2, T3, T4, T5>(_ value: (T1, T2, T3, T4, T5), reservedCapacity: Int = 4096) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable
{
    try encode(Tuple5(value), reservedCapacity: reservedCapacity)
}
public func decode<T1, T2, T3, T4, T5>(_ t: (T1, T2, T3, T4, T5).Type, from data: Data) throws -> (T1, T2, T3, T4, T5)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable
{
    try decode(from: data)
}
public func decode<T1, T2, T3, T4, T5>(from data: Data) throws -> (T1, T2, T3, T4, T5)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable
{
    try decode(Tuple5<T1, T2, T3, T4, T5>.self, from: data).tuple
}
//============== end of Tuple5 =============

//================ Tuple6 ==================
public struct Tuple6<T1, T2, T3, T4, T5, T6>: ATuple {
    public typealias STuple = (T1, T2, T3, T4, T5, T6)
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5
    public let _5: T6
    @inlinable
    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5, _ v6: T6) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5; _5 = v6
    }
    @inlinable
    public init(_ t: STuple) {
        self.init(t.0, t.1, t.2, t.3, t.4, t.5)
    }
    @inlinable
    public var tuple: STuple {
        (_0, _1, _2, _3, _4, _5)
    }
    @inlinable
    public static var count: Int { 6 }
}
extension Tuple6: LinkedTuple {
    public typealias First = T1
    public typealias Last = T6
    public typealias DroppedFirst = Tuple5<T2, T3, T4, T5, T6>
    public typealias DroppedLast = Tuple5<T1, T2, T3, T4, T5>
    @inlinable
    public init(first: DroppedLast, last: Last) {
        self.init(first._0, first._1, first._2, first._3, first._4, last)
    }
    @inlinable
    public init(first: First, last: DroppedFirst) {
        self.init(first, last._0, last._1, last._2, last._3, last._4)
    }
    public var first: First { _0 }
    public var last: Last { _5 }
    public var dropLast: DroppedLast {
        Tuple5(_0, _1, _2, _3, _4)
    }
    public var dropFirst: DroppedFirst {
        Tuple5(_1, _2, _3, _4, _5)
    }
}
public func Tuple<T1, T2, T3, T4, T5, T6>(_ t: (T1, T2, T3, T4, T5, T6)) -> Tuple6<T1, T2, T3, T4, T5, T6> {
    Tuple6(t)
}
extension Tuple6: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable
{
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(_0); try encoder.encode(_1); try encoder.encode(_2)
        try encoder.encode(_3); try encoder.encode(_4); try encoder.encode(_5)
    }
}
extension Tuple6: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable
{
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode()
        )
    }
}
extension Tuple6: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable
{
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try T1.calculateSize(in: &decoder) + T2.calculateSize(in: &decoder) + T3.calculateSize(in: &decoder) +
        T4.calculateSize(in: &decoder) + T5.calculateSize(in: &decoder) + T6.calculateSize(in: &decoder)
    }
}
public extension Decoder {
    mutating func decode<T1, T2, T3, T4, T5, T6>(_ t: (T1, T2, T3, T4, T5, T6).Type) throws -> (T1, T2, T3, T4, T5, T6)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable
    {
        try self.decode(Tuple6<T1, T2, T3, T4, T5, T6>.self).tuple
    }
    mutating func decode<T1, T2, T3, T4, T5, T6>() throws -> (T1, T2, T3, T4, T5, T6)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable
    {
        try self.decode(Tuple6<T1, T2, T3, T4, T5, T6>.self).tuple
    }
}
public extension Encoder {
    mutating func encode<T1, T2, T3, T4, T5, T6>(_ value: (T1, T2, T3, T4, T5, T6)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable
    {
        try self.encode(Tuple6(value))
    }
}
public func encode<T1, T2, T3, T4, T5, T6>(_ value: (T1, T2, T3, T4, T5, T6), reservedCapacity: Int = 4096) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable
{
    try encode(Tuple6(value), reservedCapacity: reservedCapacity)
}
public func decode<T1, T2, T3, T4, T5, T6>(_ t: (T1, T2, T3, T4, T5, T6).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable
{
    try decode(from: data)
}
public func decode<T1, T2, T3, T4, T5, T6>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable
{
    try decode(Tuple6<T1, T2, T3, T4, T5, T6>.self, from: data).tuple
}
//============== end of Tuple6 =============

//================ Tuple7 ==================
public struct Tuple7<T1, T2, T3, T4, T5, T6, T7>: ATuple {
    public typealias STuple = (T1, T2, T3, T4, T5, T6, T7)
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5
    public let _5: T6
    public let _6: T7
    @inlinable
    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5, _ v6: T6, _ v7: T7) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5; _5 = v6
        _6 = v7
    }
    @inlinable
    public init(_ t: STuple) {
        self.init(t.0, t.1, t.2, t.3, t.4, t.5, t.6)
    }
    @inlinable
    public var tuple: STuple {
        (_0, _1, _2, _3, _4, _5, _6)
    }
    @inlinable
    public static var count: Int { 7 }
}
extension Tuple7: LinkedTuple {
    public typealias First = T1
    public typealias Last = T7
    public typealias DroppedFirst = Tuple6<T2, T3, T4, T5, T6, T7>
    public typealias DroppedLast = Tuple6<T1, T2, T3, T4, T5, T6>
    @inlinable
    public init(first: DroppedLast, last: Last) {
        self.init(first._0, first._1, first._2, first._3, first._4, first._5, last)
    }
    @inlinable
    public init(first: First, last: DroppedFirst) {
        self.init(first, last._0, last._1, last._2, last._3, last._4, last._5)
    }
    public var first: First { _0 }
    public var last: Last { _6 }
    public var dropLast: DroppedLast {
        Tuple6(_0, _1, _2, _3, _4, _5)
    }
    public var dropFirst: DroppedFirst {
        Tuple6(_1, _2, _3, _4, _5, _6)
    }
}
public func Tuple<T1, T2, T3, T4, T5, T6, T7>(_ t: (T1, T2, T3, T4, T5, T6, T7)) -> Tuple7<T1, T2, T3, T4, T5, T6, T7> {
    Tuple7(t)
}
extension Tuple7: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable
{
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(_0); try encoder.encode(_1); try encoder.encode(_2)
        try encoder.encode(_3); try encoder.encode(_4); try encoder.encode(_5)
        try encoder.encode(_6)
    }
}
extension Tuple7: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable
{
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode()
        )
    }
}
extension Tuple7: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable
{
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try T1.calculateSize(in: &decoder) + T2.calculateSize(in: &decoder) + T3.calculateSize(in: &decoder) +
        T4.calculateSize(in: &decoder) + T5.calculateSize(in: &decoder) + T6.calculateSize(in: &decoder) +
        T7.calculateSize(in: &decoder)
    }
}
public extension Decoder {
    mutating func decode<T1, T2, T3, T4, T5, T6, T7>(_ t: (T1, T2, T3, T4, T5, T6, T7).Type) throws -> (T1, T2, T3, T4, T5, T6, T7)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable
    {
        try self.decode(Tuple7<T1, T2, T3, T4, T5, T6, T7>.self).tuple
    }
    mutating func decode<T1, T2, T3, T4, T5, T6, T7>() throws -> (T1, T2, T3, T4, T5, T6, T7)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable
    {
        try self.decode(Tuple7<T1, T2, T3, T4, T5, T6, T7>.self).tuple
    }
}
public extension Encoder {
    mutating func encode<T1, T2, T3, T4, T5, T6, T7>(_ value: (T1, T2, T3, T4, T5, T6, T7)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable
    {
        try self.encode(Tuple7(value))
    }
}
public func encode<T1, T2, T3, T4, T5, T6, T7>(_ value: (T1, T2, T3, T4, T5, T6, T7), reservedCapacity: Int = 4096) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable
{
    try encode(Tuple7(value), reservedCapacity: reservedCapacity)
}
public func decode<T1, T2, T3, T4, T5, T6, T7>(_ t: (T1, T2, T3, T4, T5, T6, T7).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable
{
    try decode(from: data)
}
public func decode<T1, T2, T3, T4, T5, T6, T7>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable
{
    try decode(Tuple7<T1, T2, T3, T4, T5, T6, T7>.self, from: data).tuple
}
//============== end of Tuple7 =============

//================ Tuple8 ==================
public struct Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>: ATuple {
    public typealias STuple = (T1, T2, T3, T4, T5, T6, T7, T8)
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5
    public let _5: T6
    public let _6: T7
    public let _7: T8
    @inlinable
    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5, _ v6: T6, _ v7: T7, _ v8: T8) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5; _5 = v6
        _6 = v7; _7 = v8
    }
    @inlinable
    public init(_ t: STuple) {
        self.init(t.0, t.1, t.2, t.3, t.4, t.5, t.6, t.7)
    }
    @inlinable
    public var tuple: STuple {
        (_0, _1, _2, _3, _4, _5, _6, _7)
    }
    @inlinable
    public static var count: Int { 8 }
}
extension Tuple8: LinkedTuple {
    public typealias First = T1
    public typealias Last = T8
    public typealias DroppedFirst = Tuple7<T2, T3, T4, T5, T6, T7, T8>
    public typealias DroppedLast = Tuple7<T1, T2, T3, T4, T5, T6, T7>
    @inlinable
    public init(first: DroppedLast, last: Last) {
        self.init(first._0, first._1, first._2, first._3, first._4, first._5, first._6, last)
    }
    @inlinable
    public init(first: First, last: DroppedFirst) {
        self.init(first, last._0, last._1, last._2, last._3, last._4, last._5, last._6)
    }
    public var first: First { _0 }
    public var last: Last { _7 }
    public var dropLast: DroppedLast {
        Tuple7(_0, _1, _2, _3, _4, _5, _6)
    }
    public var dropFirst: DroppedFirst {
        Tuple7(_1, _2, _3, _4, _5, _6, _7)
    }
}
public func Tuple<T1, T2, T3, T4, T5, T6, T7, T8>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8)) -> Tuple8<T1, T2, T3, T4, T5, T6, T7, T8> {
    Tuple8(t)
}
extension Tuple8: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable
{
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(_0); try encoder.encode(_1); try encoder.encode(_2)
        try encoder.encode(_3); try encoder.encode(_4); try encoder.encode(_5)
        try encoder.encode(_6); try encoder.encode(_7)
    }
}
extension Tuple8: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable
{
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode()
        )
    }
}
extension Tuple8: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable
{
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try T1.calculateSize(in: &decoder) + T2.calculateSize(in: &decoder) + T3.calculateSize(in: &decoder) +
        T4.calculateSize(in: &decoder) + T5.calculateSize(in: &decoder) + T6.calculateSize(in: &decoder) +
        T7.calculateSize(in: &decoder) + T8.calculateSize(in: &decoder)
    }
}
public extension Decoder {
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable
    {
        try self.decode(Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>.self).tuple
    }
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8>() throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable
    {
        try self.decode(Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>.self).tuple
    }
}
public extension Encoder {
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable
    {
        try self.encode(Tuple8(value))
    }
}
public func encode<T1, T2, T3, T4, T5, T6, T7, T8>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8), reservedCapacity: Int = 4096) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable
{
    try encode(Tuple8(value), reservedCapacity: reservedCapacity)
}
public func decode<T1, T2, T3, T4, T5, T6, T7, T8>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable
{
    try decode(from: data)
}
public func decode<T1, T2, T3, T4, T5, T6, T7, T8>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable
{
    try decode(Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>.self, from: data).tuple
}
//============== end of Tuple8 =============

//================ Tuple9 ==================
public struct Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>: ATuple {
    public typealias STuple = (T1, T2, T3, T4, T5, T6, T7, T8, T9)
    public let _0: T1
    public let _1: T2
    public let _2: T3
    public let _3: T4
    public let _4: T5
    public let _5: T6
    public let _6: T7
    public let _7: T8
    public let _8: T9
    @inlinable
    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5, _ v6: T6, _ v7: T7, _ v8: T8, _ v9: T9) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5; _5 = v6
        _6 = v7; _7 = v8; _8 = v9
    }
    @inlinable
    public init(_ t: STuple) {
        self.init(t.0, t.1, t.2, t.3, t.4, t.5, t.6, t.7, t.8)
    }
    @inlinable
    public var tuple: STuple {
        (_0, _1, _2, _3, _4, _5, _6, _7, _8)
    }
    @inlinable
    public static var count: Int { 9 }
}
extension Tuple9: LinkedTuple {
    public typealias First = T1
    public typealias Last = T9
    public typealias DroppedFirst = Tuple8<T2, T3, T4, T5, T6, T7, T8, T9>
    public typealias DroppedLast = Tuple8<T1, T2, T3, T4, T5, T6, T7, T8>
    @inlinable
    public init(first: DroppedLast, last: Last) {
        self.init(first._0, first._1, first._2, first._3, first._4, first._5, first._6, first._7, last)
    }
    @inlinable
    public init(first: First, last: DroppedFirst) {
        self.init(first, last._0, last._1, last._2, last._3, last._4, last._5, last._6, last._7)
    }
    public var first: First { _0 }
    public var last: Last { _8 }
    public var dropLast: DroppedLast {
        Tuple8(_0, _1, _2, _3, _4, _5, _6, _7)
    }
    public var dropFirst: DroppedFirst {
        Tuple8(_1, _2, _3, _4, _5, _6, _7, _8)
    }
}
public func Tuple<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9)) -> Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9> {
    Tuple9(t)
}
extension Tuple9: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable
{
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(_0); try encoder.encode(_1); try encoder.encode(_2)
        try encoder.encode(_3); try encoder.encode(_4); try encoder.encode(_5)
        try encoder.encode(_6); try encoder.encode(_7); try encoder.encode(_8)
    }
}
extension Tuple9: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable
{
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode()
        )
    }
}
extension Tuple9: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable,
        T9: SizeCalculable
{
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try T1.calculateSize(in: &decoder) + T2.calculateSize(in: &decoder) + T3.calculateSize(in: &decoder) +
        T4.calculateSize(in: &decoder) + T5.calculateSize(in: &decoder) + T6.calculateSize(in: &decoder) +
        T7.calculateSize(in: &decoder) + T8.calculateSize(in: &decoder) + T9.calculateSize(in: &decoder)
    }
}
public extension Decoder {
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable
    {
        try self.decode(Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>.self).tuple
    }
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
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
            T9: Encodable
    {
        try self.encode(Tuple9(value))
    }
}
public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9), reservedCapacity: Int = 4096) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable
{
    try encode(Tuple9(value), reservedCapacity: reservedCapacity)
}
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable
{
    try decode(from: data)
}
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
public struct Tuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>: ATuple {
    public typealias STuple = (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
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
    @inlinable
    public init(_ v1: T1, _ v2: T2, _ v3: T3, _ v4: T4, _ v5: T5, _ v6: T6, _ v7: T7, _ v8: T8, _ v9: T9, _ v10: T10) {
        _0 = v1; _1 = v2; _2 = v3; _3 = v4; _4 = v5; _5 = v6
        _6 = v7; _7 = v8; _8 = v9; _9 = v10
    }
    @inlinable
    public init(_ t: STuple) {
        self.init(t.0, t.1, t.2, t.3, t.4, t.5, t.6, t.7, t.8, t.9)
    }
    @inlinable
    public var tuple: STuple {
        (_0, _1, _2, _3, _4, _5, _6, _7, _8, _9)
    }
    @inlinable
    public static var count: Int { 10 }
}
extension Tuple10: LinkedTuple {
    public typealias First = T1
    public typealias Last = T10
    public typealias DroppedFirst = Tuple9<T2, T3, T4, T5, T6, T7, T8, T9, T10>
    public typealias DroppedLast = Tuple9<T1, T2, T3, T4, T5, T6, T7, T8, T9>
    @inlinable
    public init(first: DroppedLast, last: Last) {
        self.init(first._0, first._1, first._2, first._3, first._4, first._5, first._6, first._7, first._8, last)
    }
    @inlinable
    public init(first: First, last: DroppedFirst) {
        self.init(first, last._0, last._1, last._2, last._3, last._4, last._5, last._6, last._7, last._8)
    }
    public var first: First { _0 }
    public var last: Last { _9 }
    public var dropLast: DroppedLast {
        Tuple9(_0, _1, _2, _3, _4, _5, _6, _7, _8)
    }
    public var dropFirst: DroppedFirst {
        Tuple9(_1, _2, _3, _4, _5, _6, _7, _8, _9)
    }
}
public func Tuple<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)) -> Tuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10> {
    Tuple10(t)
}
extension Tuple10: Encodable
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable
{
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(_0); try encoder.encode(_1); try encoder.encode(_2)
        try encoder.encode(_3); try encoder.encode(_4); try encoder.encode(_5)
        try encoder.encode(_6); try encoder.encode(_7); try encoder.encode(_8)
        try encoder.encode(_9)
    }
}
extension Tuple10: Decodable
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable
{
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode(), decoder.decode(), decoder.decode(),
            decoder.decode()
        )
    }
}
extension Tuple10: SizeCalculable
    where
        T1: SizeCalculable, T2: SizeCalculable, T3: SizeCalculable, T4: SizeCalculable,
        T5: SizeCalculable, T6: SizeCalculable, T7: SizeCalculable, T8: SizeCalculable,
        T9: SizeCalculable, T10: SizeCalculable
{
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try T1.calculateSize(in: &decoder) + T2.calculateSize(in: &decoder) + T3.calculateSize(in: &decoder) +
        T4.calculateSize(in: &decoder) + T5.calculateSize(in: &decoder) + T6.calculateSize(in: &decoder) +
        T7.calculateSize(in: &decoder) + T8.calculateSize(in: &decoder) + T9.calculateSize(in: &decoder) +
        T10.calculateSize(in: &decoder)
    }
}
public extension Decoder {
    mutating func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10).Type) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
        where
            T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
            T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
            T9: Decodable, T10: Decodable
    {
        try self.decode(Tuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>.self).tuple
    }
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
    mutating func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)) throws
        where
            T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
            T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
            T9: Encodable, T10: Encodable
    {
        try self.encode(Tuple10(value))
    }
}
public func encode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ value: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10), reservedCapacity: Int = 4096) throws -> Data
    where
        T1: Encodable, T2: Encodable, T3: Encodable, T4: Encodable,
        T5: Encodable, T6: Encodable, T7: Encodable, T8: Encodable,
        T9: Encodable, T10: Encodable
{
    try encode(Tuple10(value), reservedCapacity: reservedCapacity)
}
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(_ t: (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10).Type, from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable
{
    try decode(from: data)
}
public func decode<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>(from data: Data) throws -> (T1, T2, T3, T4, T5, T6, T7, T8, T9, T10)
    where
        T1: Decodable, T2: Decodable, T3: Decodable, T4: Decodable,
        T5: Decodable, T6: Decodable, T7: Decodable, T8: Decodable,
        T9: Decodable, T10: Decodable
{
    try decode(Tuple10<T1, T2, T3, T4, T5, T6, T7, T8, T9, T10>.self, from: data).tuple
}
//============== end of Tuple10 =============
