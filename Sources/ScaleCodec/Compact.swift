//
//  Compact.swift
//  
//
//  Created by Yehor Popovych on 9/30/20.
//

import Foundation

public let COMPACT_MAX_BIT_WIDTH: Int = 536

public protocol CompactCodable: Hashable {
    associatedtype UI: UnsignedInteger
    
    init(uint: UI)
    init?(trimmedLittleEndianData: Data)
    
    var uint: UI { get }
    var trimmedLittleEndianData: Data { get }
    
    var compactBitsUsed: Int { get }
    static var compactBitWidth: Int { get }
}

public struct Compact<T: CompactCodable>: Equatable, Hashable {
    public enum Error: Swift.Error {
        case overflow(bitWidth: Int, value: T.UI, message: String)
    }
    
    public let value: T
    
    public init(_ value: T) {
        self.value = value
    }
}

public protocol CompactConvertible {
    init<C: CompactCodable>(compact: Compact<C>) throws
    func compact<C: CompactCodable>() throws -> Compact<C>
}

extension Compact: CompactConvertible {
    public init<C: CompactCodable>(compact: Compact<C>) throws {
        try self.init(T(compact: compact))
    }
    
    public func compact<C: CompactCodable>() throws -> Compact<C> {
        try value.compact()
    }
}

extension CompactCodable { // CompactConvertible
    public init<C: CompactCodable>(compact: Compact<C>) throws {
        guard compact.value.compactBitsUsed <= Self.compactBitWidth else {
            throw Compact<C>.Error.overflow(
                bitWidth: Self.compactBitWidth,
                value: compact.value.uint,
                message: "Can't store \(compact.value.uint) in \(Self.compactBitWidth)bit unsigned integer "
            )
        }
        self.init(uint: UI(compact.value.uint))
    }
    
    public func compact<C: CompactCodable>() throws -> Compact<C> {
        guard compactBitsUsed <= C.compactBitWidth else {
            throw Compact<Self>.Error.overflow(
                bitWidth: C.compactBitWidth,
                value: uint,
                message: "Can't store \(uint) in \(C.compactBitWidth)bit unsigned integer "
            )
        }
        return Compact(C(uint: C.UI(uint)))
    }
}

extension CompactCodable where Self: DataConvertible { // DataConvertible
    public init?(trimmedLittleEndianData bytes: Data) {
        guard let val = Self(
            data: bytes, littleEndian: true, trimmed: true
        ) else {
            return nil
        }
        self = val
    }
    
    public var trimmedLittleEndianData: Data {
        data(littleEndian: true, trimmed: true)
    }
}

extension Compact: Encodable {
    public func encode<E: Encoder>(in encoder: inout E) throws {
        switch value.compactBitsUsed {
        case 0...6: try encoder.encode(UInt8(value.uint) << 2)
        case 7...14: try encoder.encode(UInt16(value.uint) << 2 | 0b01)
        case 14...30: try encoder.encode(UInt32(value.uint) << 2 | 0b10)
        default:
            guard value.compactBitsUsed <= COMPACT_MAX_BIT_WIDTH else {
                let err = "Value is too big: \(value.uint), bits: \(value.compactBitsUsed)," +
                          "max bits: \(COMPACT_MAX_BIT_WIDTH)"
                throw EncodingError.invalidValue(
                    self,
                    EncodingError.Context(
                        path: encoder.path,
                        description: err
                    )
                )
            }
            let data = value.trimmedLittleEndianData
            encoder.write(UInt8(data.count - 4) << 2 | 0b11)
            encoder.write(data)
        }
    }
}

extension Compact: Decodable {
    public init<D: Decoder>(from decoder: inout D) throws {
        let first = try decoder.peek()
        switch first & 0b11 {
        case 0b00:
            let val = try decoder.decode(UInt8.self) >> 2
            value = T.self == UInt8.self ? val as! T : T(uint: T.UI(val))
        case 0b01:
            let val = try decoder.decode(UInt16.self) >> 2
            try Self.checkSize(bits: val.compactBitsUsed, decoder: decoder)
            value = T.self == UInt16.self ? val as! T : T(uint: T.UI(val))
        case 0b10:
            let val = try decoder.decode(UInt32.self) >> 2
            try Self.checkSize(bits: val.compactBitsUsed, decoder: decoder)
            value = T.self == UInt32.self ? val as! T : T(uint: T.UI(val))
        case 0b11:
            let len = try decoder.decode(UInt8.self) >> 2 + 4
            let bytes = try decoder.read(count: Int(len))
            guard let val = T(trimmedLittleEndianData: bytes) else {
                throw DecodingError.dataCorrupted(
                    decoder.errorContext("Can't init \(T.self) with bytes \(bytes)")
                )
            }
            try Self.checkSize(bits: val.compactBitsUsed, decoder: decoder)
            value = val
        default: fatalError() // Only to silence compiler error
        }
    }
}

extension Compact: SizeCalculable {
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        let size = try calculateSizeNoSkip(in: &decoder)
        try decoder.skip(count: size)
        return size
    }
}

public extension Compact {
    static func calculateSizeNoSkip<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        let first = try decoder.peek()
        switch first & 0b11 {
        case 0b00: return 1
        case 0b01: return 2
        case 0b10: return 4
        case 0b11: return Int(first >> 2 + 4) + 1
        default: fatalError() // Only to silence compiler error
        }
    }
}

extension CustomDecoderFactory where T: CompactCodable {
    public static var compact: CustomDecoderFactory {
        CustomDecoderFactory { try $0.decode(Compact<T>.self).value }
    }
}

extension CustomEncoderFactory where T: CompactCodable {
    public static var compact: CustomEncoderFactory {
        CustomEncoderFactory { try $0.encode(Compact($1)) }
    }
}

extension Compact {
    private static func checkSize(bits: Int, decoder: Decoder) throws {
        if T.compactBitWidth < bits {
            throw DecodingError.typeMismatch(
                T.self,
                DecodingError.Context(
                    path: decoder.path,
                    description: "Can't store \(bits) bits in \(T.self)"
                )
            )
        }
    }
}

extension UnsignedInteger where Self: CompactCodable, UI == Self {
    public init(uint: UI) {
        self.init(uint)
    }
    public var uint: UI { self }
}

extension FixedWidthInteger where Self: CompactCodable, UI == Self {
    public var compactBitsUsed: Int { bitWidth - leadingZeroBitCount }
    public static var compactMax: Self {
        bitWidth > COMPACT_MAX_BIT_WIDTH ? Self(1) << COMPACT_MAX_BIT_WIDTH - 1 : max
    }
    public static var compactBitWidth: Int {
        bitWidth > COMPACT_MAX_BIT_WIDTH ? COMPACT_MAX_BIT_WIDTH : bitWidth
    }
}

extension UInt8: CompactCodable, CompactConvertible {}
extension UInt16: CompactCodable, CompactConvertible {}
extension UInt32: CompactCodable, CompactConvertible {}
extension UInt64: CompactCodable, CompactConvertible {}
