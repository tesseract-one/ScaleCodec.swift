//
//  Compact.swift
//  
//
//  Created by Yehor Popovych on 9/30/20.
//

import Foundation
@_exported import BigInt

private let SCOMPACT_MAX_VALUE = BigUInt(2).power(536) - 1

public protocol CompactConvertible {
    init<C: CompactCodable>(compact: SCompact<C>) throws
    func compact<C: CompactCodable>() throws -> SCompact<C>
}

public protocol CompactCodable: Hashable {
    associatedtype UI: UnsignedInteger
    
    init(uintValue: UI)
    var int: UI { get }
    
    static var compactMax: UI { get }
}

public struct SCompact<T: CompactCodable>: Equatable, Hashable {
    public let value: T
    
    public init(_ value: T) {
        self.value = value
    }
}

extension SCompact: CompactConvertible {
    public init<C: CompactCodable>(compact: SCompact<C>) throws {
        try self.init(T(compact: compact))
    }
    
    public func compact<C: CompactCodable>() throws -> SCompact<C> {
        try value.compact()
    }
}

extension CompactCodable {
    public init<C: CompactCodable>(compact: SCompact<C>) throws {
        guard compact.value.int <= Self.compactMax else {
            let bitWidth = MemoryLayout<UI>.size * 8
            throw ScaleFixedIntegerError.overflow(
                bitWidth: bitWidth,
                value: BigInt(compact.value.int),
                message: "Can't store \(compact.value.int) in \(bitWidth)bit unsigned integer "
            )
        }
        self.init(uintValue: UI(compact.value.int))
    }
    
    public func compact<C: CompactCodable>() throws -> SCompact<C> {
        guard int <= C.compactMax else {
            let bitWidth = MemoryLayout<C.UI>.size * 8
            throw ScaleFixedIntegerError.overflow(
                bitWidth: bitWidth,
                value: BigInt(int),
                message: "Can't store \(int) in \(bitWidth)bit unsigned integer "
            )
        }
        return SCompact(C(uintValue: C.UI(int)))
    }
}

extension SCompact: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        let u32 = UInt32(clamping: value.int)
        switch u32 {
        case 0x00...0x3f: try encoder.encode(UInt8(value.int) << 2)
        case 0x40...0x3fff: try encoder.encode(UInt16(value.int) << 2 | 0b01)
        case 0x4000...0x3fffffff: try encoder.encode(UInt32(value.int) << 2 | 0b10)
        default: // BigUInt
            let buint = value.int as? BigUInt ?? BigUInt(value.int)
            if buint > BigUInt.compactMax {
                throw SEncodingError.invalidValue(
                    self,
                    SEncodingError.Context(
                        path: encoder.path,
                        description: "Value is too big: \(buint), max: \(BigUInt.compactMax)"
                    )
                )
            }
            buint.serialize().withUnsafeBytes { bytes in
                var data = Data(bytes)
                data.reverse()
                data.insert(UInt8(bytes.count - 4) << 2 | 0b11, at: 0)
                encoder.write(data)
            }
        }
    }
}

extension SCompact: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let first = try decoder.peekOrError(count: 1, type: type(of: self)).first!
        switch first & 0b11 {
        case 0b00:
            let val = try decoder.decode(UInt8.self) >> 2
            value = T.self == UInt8.self ? val as! T : T(uintValue: T.UI(val))
        case 0b01:
            let val = try decoder.decode(UInt16.self) >> 2
            try Self.checkSize(value: val, decoder: decoder)
            value = T.self == UInt16.self ? val as! T : T(uintValue: T.UI(val))
        case 0b10:
            let val = try decoder.decode(UInt32.self) >> 2
            try Self.checkSize(value: val, decoder: decoder)
            value = T.self == UInt32.self ? val as! T : T(uintValue: T.UI(val))
        case 0b11:
            let len = try decoder.decode(UInt8.self) >> 2 + 4
            var bytes = try decoder.readOrError(count: Int(len), type: type(of: self))
            bytes.reverse()
            let val = BigUInt(bytes)
            try Self.checkSize(value: val, decoder: decoder)
            value = T.self == BigUInt.self ? val as! T : T(uintValue: T.UI(val))
        default: fatalError() // Only to silence compiler error
        }
    }
}

extension ScaleCustomDecoderFactory where T: CompactCodable {
    public static var compact: ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { try $0.decode(SCompact<T>.self).value }
    }
}

extension ScaleCustomEncoderFactory where T: CompactCodable {
    public static var compact: ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { try $0.encode(SCompact($1)) }
    }
}

extension SCompact {
    private static func checkSize<T2>(value: T2, decoder: ScaleDecoder) throws
        where T2: UnsignedInteger
    {
        if T.compactMax < value {
            throw SDecodingError.typeMismatch(
                T.self,
                SDecodingError.Context(
                    path: decoder.path,
                    description: "Can't store \(value) in \(T.self)"
                )
            )
        }
    }
}

extension UnsignedInteger where Self: CompactCodable {
    public init(uintValue: UI) {
        self.init(uintValue)
    }
    
    public var int: UI { self as! UI }
}

extension UInt8: CompactCodable {
    public typealias UI = UInt8
    
    public static var compactMax: UI {
        return Self.max
    }
}

extension UInt8: CompactConvertible {}

extension UInt16: CompactCodable {
    public typealias UI = UInt16
    
    public static var compactMax: UI {
        return Self.max
    }
}

extension UInt16: CompactConvertible {}

extension UInt32: CompactCodable {
    public typealias UI = UInt32
    
    public static var compactMax: UI {
        return Self.max
    }
}

extension UInt32: CompactConvertible {}

extension UInt64: CompactCodable {
    public typealias UI = UInt64
    
    public static var compactMax: UI {
        return Self.max
    }
}

extension UInt64: CompactConvertible {}

extension BigUInt: CompactCodable {
    public typealias UI = BigUInt
    
    public static var compactMax: UI {
        return SCOMPACT_MAX_VALUE
    }
}

extension BigUInt: CompactConvertible {}
