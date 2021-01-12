//
//  BigUIntegers.swift
//  
//
//  Created by Yehor Popovych on 1/13/21.
//

import Foundation
import BigInt

public protocol ScaleFixedUnsignedInteger:
    ScaleFixedData, CompactConvertible, CompactCodable, ExpressibleByIntegerLiteral
{
    init(bigUInt int: BigUInt) throws
    
    static var bitWidth: Int { get }
    static var max: BigUInt { get }
    static var min: BigUInt { get }
}

extension ScaleFixedUnsignedInteger where UI == BigUInt {
    public init(_ int: UI) {
        try! self.init(bigUInt: int)
    }
    
    public init?(exactly value: BigUInt) {
        do {
            try self.init(bigUInt: value)
        } catch {
            return nil
        }
    }
    
    public init<T>(_ source: T) where T : BinaryInteger {
        self.init(BigUInt(source))
    }
    
    public init(integerLiteral value: UInt64) {
        self.init(BigUInt(integerLiteral: value))
    }
    
    public init(uintValue: UI) {
        self.init(uintValue)
    }
    
    public init<C: CompactCodable>(compact: SCompact<C>) throws {
        try self.init(bigUInt: BigUInt(compact.value.int))
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
    
    public init(decoding data: Data) throws {
        var data: Data = data
        data.reverse()
        try self.init(bigUInt: BigUInt(data))
    }
    
    public func encode() throws -> Data {
        return int.serialize().withUnsafeBytes { bytes in
            var data = Data(bytes)
            data.reverse()
            data += Data(repeating: 0x00, count: Self.fixedBytesCount - data.count)
            return data
        }
    }
    
    public static func checkSizeBounds(_ value: BigUInt) throws {
        guard value <= Self.max else {
            throw ScaleFixedIntegerError.overflow(
                bitWidth: Self.bitWidth,
                value: BigInt(value),
                message: "Can't store \(value) in \(Self.bitWidth)bit unsigned integer")
        }
    }
    
    public static var fixedBytesCount: Int { return Self.bitWidth / 8 }
    public static var compactMax: UI { Self.max }
}

public struct SUInt128: ScaleFixedUnsignedInteger, Equatable, Hashable {
    public typealias UI = BigUInt
    public typealias IntegerLiteralType = UInt64
    
    public let int: BigUInt
    
    public init(bigUInt int: BigUInt) throws {
        try Self.checkSizeBounds(int)
        self.int = int
    }
    
    public static let bitWidth: Int = 128
    public static let max: BigUInt = BigUInt(2).power(128) - 1
    public static let min: BigUInt = BigUInt(0)
}

public struct SUInt256: ScaleFixedUnsignedInteger, Equatable, Hashable {
    public typealias UI = BigUInt
    public typealias IntegerLiteralType = UInt64
    
    public let int: BigUInt
    
    public init(bigUInt int: BigUInt) throws {
        try Self.checkSizeBounds(int)
        self.int = int
    }
    
    public static let bitWidth: Int = 256
    public static let max: BigUInt = BigUInt(2).power(256) - 1
    public static let min: BigUInt = BigUInt(0)
}

public struct SUInt512: ScaleFixedUnsignedInteger, Equatable, Hashable {
    public typealias UI = BigUInt
    public typealias IntegerLiteralType = UInt64
    
    public let int: BigUInt
    
    public init(bigUInt int: BigUInt) throws {
        try Self.checkSizeBounds(int)
        self.int = int
    }
    
    public static let bitWidth: Int = 512
    public static let max: BigUInt = BigUInt(2).power(512) - 1
    public static let min: BigUInt = BigUInt(0)
}

extension BinaryInteger {
    public init<I: ScaleFixedUnsignedInteger>(_ source: I) {
        self.init(source.int)
    }
    
    public init<I: ScaleFixedUnsignedInteger>(truncatingIfNeeded source: I) {
        self.init(truncatingIfNeeded: source.int)
    }
    
    public init<I: ScaleFixedUnsignedInteger>(clamping source: I) {
        self.init(clamping: source.int)
    }
    
    public init?<I: ScaleFixedUnsignedInteger>(exactly source: I) {
        self.init(exactly: source.int)
    }
}

extension ScaleCustomEncoderFactory where T == BigUInt {
    public static var b128: ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { try $0.encode(SUInt128(bigUInt: $1)) }
    }
    public static var b256: ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { try $0.encode(SUInt256(bigUInt: $1)) }
    }
    public static var b512: ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { try $0.encode(SUInt512(bigUInt: $1)) }
    }
}

extension ScaleCustomDecoderFactory where T == BigUInt {
    public static var b128: ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { try $0.decode(SUInt128.self).int }
    }
    public static var b256: ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { try $0.decode(SUInt256.self).int }
    }
    public static var b512: ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { try $0.decode(SUInt512.self).int }
    }
}
