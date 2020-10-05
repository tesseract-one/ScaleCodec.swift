//
//  Compact.swift
//  
//
//  Created by Yehor Popovych on 9/30/20.
//

import Foundation
@_exported import BigInt

private let SCOMPACT_MAX_VALUE = BigUInt(2).power(536) - 1

public protocol CompactCodable: UnsignedInteger {
    static var compactMax: Self { get }
}

public struct SCompact<T: CompactCodable>: Equatable, Hashable {
    public let value: T;
    
    public init(_ value: T) {
        self.value = value
    }
}

extension SCompact: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        let u32 = UInt32(clamping: value)
        switch u32 {
        case 0x00...0x3f: try encoder.encode(UInt8(value) << 2)
        case 0x40...0x3fff: try encoder.encode(UInt16(value) << 2 | 0b01)
        case 0x4000...0x3fffffff: try encoder.encode(UInt32(value) << 2 | 0b10)
        default: // BigUInt
            let buint = value as? BigUInt ?? BigUInt(value)
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
                encoder.write([UInt8(bytes.count - 4) << 2 | 0b11] + bytes.reversed())
            }
        }
    }
}

extension SCompact: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let first = try decoder.peekOrError(count: 1, type: type(of: self))[0]
        switch first & 0b11 {
        case 0b00:
            value = try T(decoder.decode(UInt8.self) >> 2)
        case 0b01:
            let val = try decoder.decode(UInt16.self) >> 2
            try checkSize(T.self, value: val, decoder: decoder)
            value = T(val)
        case 0b10:
            let val = try decoder.decode(UInt32.self) >> 2
            try checkSize(T.self, value: val, decoder: decoder)
            value = T(val)
        case 0b11:
            let len = try decoder.decode(UInt8.self) >> 2 + 4
            let bytes = try decoder.readOrError(count: Int(len), type: type(of: self))
            let val = BigUInt(Data(bytes.reversed()))
            try checkSize(T.self, value: val, decoder: decoder)
            value = T.self == BigUInt.self ? val as! T : T(val)
        default: fatalError() // Only to silence compiler error
        }
    }
}

public enum SCompactTypeMarker {
    case compact
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T: CompactCodable>(compact: T) throws -> ScaleEncoder {
        return try self.encode(SCompact(compact))
    }
}

extension ScaleDecoder {
    public func decode<T: CompactCodable>(_ type: T.Type, _ marker: SCompactTypeMarker) throws -> T {
        return try self.decode(marker)
    }
    
    public func decode<T: CompactCodable>(_ marker: SCompactTypeMarker) throws -> T {
        return try self.decode(SCompact<T>.self).value
    }
}

extension SCALE {
    public func encode<T: CompactCodable>(compact: T) throws -> Data {
        return try self.encoder().encode(compact: compact).output
    }
    
    public func decode<T: CompactCodable>(_ type: T.Type, _ marker: SCompactTypeMarker, from data: Data) throws -> T {
        return try self.decode(marker, from: data)
    }
    
    public func decode<T: CompactCodable>(_ marker: SCompactTypeMarker, from data: Data) throws -> T {
        return try self.decoder(data: data).decode(marker)
    }
}

private func checkSize<T1, T2>(_ type: T1.Type, value: T2, decoder: ScaleDecoder) throws
    where T1: CompactCodable, T2: UnsignedInteger
{
    if T1.compactMax < value {
        throw SDecodingError.typeMismatch(
            type,
            SDecodingError.Context(
                path: decoder.path,
                description: "Can't store \(value) in \(type)"
            )
        )
    }
}

extension UInt8: CompactCodable {
    public static var compactMax: UInt8 {
        return Self.max
    }
}

extension UInt16: CompactCodable {
    public static var compactMax: UInt16 {
        return Self.max
    }
}

extension UInt32: CompactCodable {
    public static var compactMax: UInt32 {
        return Self.max
    }
}

extension UInt64: CompactCodable {
    public static var compactMax: UInt64 {
        return Self.max
    }
}

extension BigUInt: CompactCodable {
    public static var compactMax: BigUInt {
        return SCOMPACT_MAX_VALUE
    }
}
