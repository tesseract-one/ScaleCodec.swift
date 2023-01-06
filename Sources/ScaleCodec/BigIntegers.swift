//
//  BigIntegers.swift
//  
//
//  Created by Yehor Popovych on 10/6/20.
//

import Foundation
import BigInt

public protocol ScaleFixedSignedInteger: ScaleFixedData, ExpressibleByIntegerLiteral
    where IntegerLiteralType: SignedInteger
{
    var int: BigInt { get }
    
    init(bigInt int: BigInt) throws
    
    static var bitWidth: Int { get }
    static var overflowValue: BigInt { get }
    static var biMax: BigInt { get }
    static var biMin: BigInt { get }
}

extension ScaleFixedSignedInteger {
    public static func checkSizeBounds(_ value: BigInt) throws {
        guard value <= Self.biMax && value >= Self.biMin else {
            throw ScaleFixedIntegerError.overflow(
                bitWidth: Self.bitWidth,
                value: value,
                message: "Can't store \(value) in \(Self.bitWidth)bit signed integer")
        }
    }
}

public protocol ScaleFixedSignedIntegerImpl: ScaleFixedSignedInteger, Hashable, Equatable {}

extension ScaleFixedSignedIntegerImpl {
    public init(_ value: BigInt) {
        try! self.init(bigInt: value)
    }
    
    public init?(exactly value: BigInt) {
        do {
            try self.init(bigInt: value)
        } catch {
            return nil
        }
    }
    
    public init<T>(_ source: T) where T : BinaryInteger {
        self.init(BigInt(source))
    }
    
    public init(integerLiteral value: Int64) {
        self.init(BigInt(integerLiteral: value))
    }
    
    public init(decoding data: Data) throws {
        var data: Data = data
        data.reverse()
        let uint = BigUInt(data)
        let int = uint > Self.biMax
            ? BigInt(sign: .minus, magnitude: (Self.overflowValue - BigInt(uint)).magnitude)
            : BigInt(sign: .plus, magnitude: uint)
        try self.init(bigInt: int)
    }
    
    public func encode() throws -> Data {
        var buint: BigUInt
        switch int.sign {
        case .plus: buint = int.magnitude
        case .minus: buint = (Self.overflowValue + int).magnitude
        }
        return buint.serialize().withUnsafeBytes { bytes in
            var data = Data(bytes)
            data.reverse()
            data += Data(repeating: 0x00, count: Self.fixedBytesCount - data.count)
            return data
        }
    }
    
    public static var fixedBytesCount: Int { return Self.bitWidth / 8 }
}

public enum ScaleFixedIntegerError: Error {
    case overflow(bitWidth: Int, value: BigInt, message: String)
}

public struct SInt128: ScaleFixedSignedIntegerImpl {
    public typealias IntegerLiteralType = Int64
    
    public let int: BigInt
    
    public init(bigInt int: BigInt) throws {
        try Self.checkSizeBounds(int)
        self.int = int
    }
    
    public static let bitWidth: Int = 128
    public static let biMax: BigInt = BigInt(2).power(127) - 1
    public static let biMin: BigInt = BigInt(-2).power(127)
    public static let overflowValue: BigInt = BigInt(2).power(128)
}

public struct SInt256: ScaleFixedSignedIntegerImpl {
    public typealias IntegerLiteralType = Int64
    
    public let int: BigInt
    
    public init(_ value: BigInt) {
        try! self.init(bigInt: value)
    }
    
    public init(bigInt int: BigInt) throws {
        try Self.checkSizeBounds(int)
        self.int = int
    }
    
    public static let bitWidth: Int = 256
    public static let biMax: BigInt = BigInt(2).power(255) - 1
    public static let biMin: BigInt = BigInt(-2).power(255)
    public static let overflowValue: BigInt = BigInt(2).power(256)
}

public struct SInt512: ScaleFixedSignedIntegerImpl {
    public typealias IntegerLiteralType = Int64
    
    public let int: BigInt
    
    public init(_ value: BigInt) {
        try! self.init(bigInt: value)
    }
    
    public init(bigInt int: BigInt) throws {
        try Self.checkSizeBounds(int)
        self.int = int
    }
    
    public static let bitWidth: Int = 512
    public static let biMax: BigInt = BigInt(2).power(511) - 1
    public static let biMin: BigInt = BigInt(-2).power(511)
    public static let overflowValue: BigInt = BigInt(2).power(512)
}

extension BinaryInteger {
    public init<I: ScaleFixedSignedInteger>(_ source: I) {
        self.init(source.int)
    }
    
    public init<I: ScaleFixedSignedInteger>(truncatingIfNeeded source: I) {
        self.init(truncatingIfNeeded: source.int)
    }
    
    public init<I: ScaleFixedSignedInteger>(clamping source: I) {
        self.init(clamping: source.int)
    }
    
    public init?<I: ScaleFixedSignedInteger>(exactly source: I) {
        self.init(exactly: source.int)
    }
}

extension ScaleCustomEncoderFactory where T == BigInt {
    public static var b128: ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { try $0.encode(SInt128(bigInt: $1)) }
    }
    public static var b256: ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { try $0.encode(SInt256(bigInt: $1)) }
    }
    public static var b512: ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { try $0.encode(SInt512(bigInt: $1)) }
    }
}

extension ScaleCustomDecoderFactory where T == BigInt {
    public static var b128: ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { try $0.decode(SInt128.self).int }
    }
    public static var b256: ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { try $0.decode(SInt256.self).int }
    }
    public static var b512: ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { try $0.decode(SInt512.self).int }
    }
}

extension SignedInteger where Self: ScaleFixedSignedInteger & FixedWidthInteger {
    public var int: BigInt { BigInt(self) }
    
    public init(bigInt int: BigInt) throws {
        try Self.checkSizeBounds(int)
        self.init(int)
    }
    
    public static var overflowValue: BigInt { biMax + 1 }
    public static var biMax: BigInt { BigInt(Self.max) }
    public static var biMin: BigInt { BigInt(Self.min) }
}

extension Int8: ScaleFixedSignedInteger {}
extension Int16: ScaleFixedSignedInteger {}
extension Int32: ScaleFixedSignedInteger {}
extension Int64: ScaleFixedSignedInteger {}
