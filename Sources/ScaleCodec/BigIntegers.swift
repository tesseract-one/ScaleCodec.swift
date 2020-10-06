//
//  BigIntegers.swift
//  
//
//  Created by Yehor Popovych on 10/6/20.
//

import Foundation
import BigInt

public protocol ScaleFixedUnsignedInteger: ScaleFixedData {
    var value: BigUInt { get }
    
    init(bigUInt value: BigUInt) throws
    
    static var bitWidth: Int { get }
    static var max: BigUInt { get }
    static var min: BigUInt { get }
}

extension ScaleFixedUnsignedInteger {
    public init(_ value: BigUInt) {
        try! self.init(bigUInt: value)
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
    
    public init(decoding data: Data) throws {
        var data: Data = data
        data.reverse()
        try self.init(bigUInt: BigUInt(data))
    }
    
    public func encode() throws -> Data {
        return value.serialize().withUnsafeBytes { bytes in
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
}

public protocol ScaleFixedSignedInteger: ScaleFixedData {
    var value: BigInt { get }
    
    init(bigInt value: BigInt) throws
    
    static var bitWidth: Int { get }
    static var overflowValue: BigInt { get }
    static var max: BigInt { get }
    static var min: BigInt { get }
}

extension ScaleFixedSignedInteger {
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
    
    public init(decoding data: Data) throws {
        var data: Data = data
        data.reverse()
        let uint = BigUInt(data)
        let int = uint > Self.max
            ? BigInt(sign: .minus, magnitude: (Self.overflowValue - BigInt(uint)).magnitude)
            : BigInt(sign: .plus, magnitude: uint)
        try self.init(bigInt: int)
    }
    
    public func encode() throws -> Data {
        var buint: BigUInt
        switch value.sign {
        case .plus: buint = value.magnitude
        case .minus: buint = (Self.overflowValue + value).magnitude
        }
        return buint.serialize().withUnsafeBytes { bytes in
            var data = Data(bytes)
            data.reverse()
            data += Data(repeating: 0x00, count: Self.fixedBytesCount - data.count)
            return data
        }
    }
    
    public static func checkSizeBounds(_ value: BigInt) throws {
        guard value <= Self.max && value >= Self.min else {
            throw ScaleFixedIntegerError.overflow(
                bitWidth: Self.bitWidth,
                value: value,
                message: "Can't store \(value) in \(Self.bitWidth)bit signed integer")
        }
    }
    
    public static var fixedBytesCount: Int { return Self.bitWidth / 8 }
}

public enum ScaleFixedIntegerError: Error {
    case overflow(bitWidth: Int, value: BigInt, message: String)
}

public struct SUInt128: ScaleFixedUnsignedInteger, Equatable, Hashable {
    public let value: BigUInt
    
    public init(bigUInt value: BigUInt) throws {
        try Self.checkSizeBounds(value)
        self.value = value
    }
    
    public static let bitWidth: Int = 128
    public static let max: BigUInt = BigUInt(2).power(128) - 1
    public static let min: BigUInt = BigUInt(0)
}

public struct SUInt256: ScaleFixedUnsignedInteger, Equatable, Hashable {
    public let value: BigUInt
    
    public init(bigUInt value: BigUInt) throws {
        try Self.checkSizeBounds(value)
        self.value = value
    }
    
    public static let bitWidth: Int = 256
    public static let max: BigUInt = BigUInt(2).power(256) - 1
    public static let min: BigUInt = BigUInt(0)
}

public struct SUInt512: ScaleFixedUnsignedInteger, Equatable, Hashable {
    public let value: BigUInt
    
    public init(bigUInt value: BigUInt) throws {
        try Self.checkSizeBounds(value)
        self.value = value
    }
    
    public static let bitWidth: Int = 512
    public static let max: BigUInt = BigUInt(2).power(512) - 1
    public static let min: BigUInt = BigUInt(0)
}

public struct SInt128: ScaleFixedSignedInteger, Equatable, Hashable {
    public let value: BigInt
    
    public init(bigInt value: BigInt) throws {
        try Self.checkSizeBounds(value)
        self.value = value
    }
    
    public static let bitWidth: Int = 128
    public static let max: BigInt = BigInt(2).power(127) - 1
    public static let min: BigInt = BigInt(-2).power(127)
    public static let overflowValue: BigInt = BigInt(2).power(128)
}

public struct SInt256: ScaleFixedSignedInteger, Equatable, Hashable {
    public let value: BigInt
    
    public init(bigInt value: BigInt) throws {
        try Self.checkSizeBounds(value)
        self.value = value
    }
    
    public static let bitWidth: Int = 256
    public static let max: BigInt = BigInt(2).power(255) - 1
    public static let min: BigInt = BigInt(-2).power(255)
    public static let overflowValue: BigInt = BigInt(2).power(256)
}

public struct SInt512: ScaleFixedSignedInteger, Equatable, Hashable {
    public let value: BigInt
    
    public init(bigInt value: BigInt) throws {
        try Self.checkSizeBounds(value)
        self.value = value
    }
    
    public static let bitWidth: Int = 512
    public static let max: BigInt = BigInt(2).power(511) - 1
    public static let min: BigInt = BigInt(-2).power(511)
    public static let overflowValue: BigInt = BigInt(2).power(512)
}

public enum SBigIntTypeMarker {
    case b128
    case b256
    case b512
}

extension ScaleEncoder {
    @discardableResult
    public func encode(b128: BigInt) throws -> ScaleEncoder {
        return try self.encode(SInt128(bigInt: b128))
    }
    
    @discardableResult
    public func encode(b128: BigUInt) throws -> ScaleEncoder {
        return try self.encode(SUInt128(bigUInt: b128))
    }
    
    @discardableResult
    public func encode(b256: BigInt) throws -> ScaleEncoder {
        return try self.encode(SInt256(bigInt: b256))
    }
    
    @discardableResult
    public func encode(b256: BigUInt) throws -> ScaleEncoder {
        return try self.encode(SUInt256(bigUInt: b256))
    }
    
    @discardableResult
    public func encode(b512: BigInt) throws -> ScaleEncoder {
        return try self.encode(SInt512(bigInt: b512))
    }
    
    @discardableResult
    public func encode(b512: BigUInt) throws -> ScaleEncoder {
        return try self.encode(SUInt512(bigUInt: b512))
    }
}

extension ScaleDecoder {
    public func decode(_ type: BigInt.Type, _ marker: SBigIntTypeMarker) throws -> BigInt {
        return try self.decode(marker)
    }
    
    public func decode(_ type: BigUInt.Type, _ marker: SBigIntTypeMarker) throws -> BigUInt {
        return try self.decode(marker)
    }

    public func decode(_ marker: SBigIntTypeMarker) throws -> BigInt {
        switch marker {
        case .b128: return try self.decode(SInt128.self).value
        case .b256: return try self.decode(SInt256.self).value
        case .b512: return try self.decode(SInt512.self).value
        }
    }
    
    public func decode(_ marker: SBigIntTypeMarker) throws -> BigUInt {
        switch marker {
        case .b128: return try self.decode(SUInt128.self).value
        case .b256: return try self.decode(SUInt256.self).value
        case .b512: return try self.decode(SUInt512.self).value
        }
    }
}

extension SCALE {
    @discardableResult
    public func encode(b128: BigInt) throws -> Data {
        return try self.encoder().encode(b128: b128).output
    }
    
    @discardableResult
    public func encode(b128: BigUInt) throws -> Data {
        return try self.encoder().encode(b128: b128).output
    }
    
    @discardableResult
    public func encode(b256: BigInt) throws -> Data {
        return try self.encoder().encode(b256: b256).output
    }
    
    @discardableResult
    public func encode(b256: BigUInt) throws -> Data {
        return try self.encoder().encode(b256: b256).output
    }
    
    @discardableResult
    public func encode(b512: BigInt) throws -> Data {
        return try self.encoder().encode(b512: b512).output
    }
    
    @discardableResult
    public func encode(b512: BigUInt) throws -> Data {
        return try self.encoder().encode(b512: b512).output
    }

    public func decode(_ type: BigInt.Type, _ marker: SBigIntTypeMarker, from data: Data) throws -> BigInt {
        return try self.decode(marker, from: data)
    }
    
    public func decode(_ type: BigUInt.Type, _ marker: SBigIntTypeMarker, from data: Data) throws -> BigUInt {
        return try self.decode(marker, from: data)
    }

    public func decode(_ marker: SBigIntTypeMarker, from data: Data) throws -> BigInt {
        return try self.decoder(data: data).decode(marker)
    }
    
    public func decode(_ marker: SBigIntTypeMarker, from data: Data) throws -> BigUInt {
        return try self.decoder(data: data).decode(marker)
    }
}

