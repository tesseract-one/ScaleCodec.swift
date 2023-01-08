//
//  Compact.swift
//  
//
//  Created by Yehor Popovych on 9/30/20.
//

import Foundation

public protocol CompactCodable: Hashable {
    associatedtype UI: UnsignedInteger
    
    init(uint: UI)
    init(littleEndianData data: Data) throws
    
    var uint: UI { get }
    var littleEndianData: Data { get }
    
    static var compactBitWidth: Int { get }
    static var compactMax: UI { get }
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

extension CompactCodable {
    public init<C: CompactCodable>(compact: Compact<C>) throws {
        guard compact.value.uint <= Self.compactMax else {
            throw Compact<C>.Error.overflow(
                bitWidth: Self.compactBitWidth,
                value: compact.value.uint,
                message: "Can't store \(compact.value.uint) in \(Self.compactBitWidth)bit unsigned integer "
            )
        }
        self.init(uint: UI(compact.value.uint))
    }
    
    public func compact<C: CompactCodable>() throws -> Compact<C> {
        guard uint <= C.compactMax else {
            throw Compact<Self>.Error.overflow(
                bitWidth: C.compactBitWidth,
                value: uint,
                message: "Can't store \(uint) in \(C.compactBitWidth)bit unsigned integer "
            )
        }
        return Compact(C(uint: C.UI(uint)))
    }
}

extension Compact: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        let u32 = UInt32(clamping: value.uint)
        switch u32 {
        case 0x00...0x3f: try encoder.encode(UInt8(value.uint) << 2)
        case 0x40...0x3fff: try encoder.encode(UInt16(value.uint) << 2 | 0b01)
        case 0x4000...0x3fffffff: try encoder.encode(UInt32(value.uint) << 2 | 0b10)
        default:
            if value.uint > T.compactMax {
                throw SEncodingError.invalidValue(
                    self,
                    SEncodingError.Context(
                        path: encoder.path,
                        description: "Value is too big: \(value.uint), max: \(T.compactMax)"
                    )
                )
            }
            var data = value.littleEndianData
            data.insert(UInt8(data.count - 4) << 2 | 0b11, at: 0)
            encoder.write(data)
        }
    }
}

extension Compact: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let first = try decoder.peekOrError(count: 1, type: type(of: self)).first!
        switch first & 0b11 {
        case 0b00:
            let val = try decoder.decode(UInt8.self) >> 2
            value = T.self == UInt8.self ? val as! T : T(uint: T.UI(val))
        case 0b01:
            let val = try decoder.decode(UInt16.self) >> 2
            try Self.checkSize(value: val, decoder: decoder)
            value = T.self == UInt16.self ? val as! T : T(uint: T.UI(val))
        case 0b10:
            let val = try decoder.decode(UInt32.self) >> 2
            try Self.checkSize(value: val, decoder: decoder)
            value = T.self == UInt32.self ? val as! T : T(uint: T.UI(val))
        case 0b11:
            let len = try decoder.decode(UInt8.self) >> 2 + 4
            let bytes = try decoder.readOrError(count: Int(len), type: type(of: self))
            value = try T(littleEndianData: bytes)
            try Self.checkSize(value: value.uint, decoder: decoder)
        default: fatalError() // Only to silence compiler error
        }
    }
}

extension ScaleCustomDecoderFactory where T: CompactCodable {
    public static var compact: ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { try $0.decode(Compact<T>.self).value }
    }
}

extension ScaleCustomEncoderFactory where T: CompactCodable {
    public static var compact: ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { try $0.encode(Compact($1)) }
    }
}

extension Compact {
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

extension UnsignedInteger where Self: CompactCodable, UI == Self {
    public init(uint: UI) {
        self.init(uint)
    }
    public var uint: UI { self }
}

extension FixedWidthInteger where Self: ScaleFixedData & CompactCodable, UI == Self {
    public init(littleEndianData data: Data) throws {
        var data = data
        if data.count < Self.fixedBytesCount {
            data.append(contentsOf: Array(repeating: 0,
                                          count: Self.fixedBytesCount - data.count))
        }
        try self.init(decoding: data)
    }
    
    public var littleEndianData: Data {
        let data = try! self.encode()
        guard let index = data.lastIndex(where: { $0 != 0 }) else {
            return Data()
        }
        return data.prefix(upTo: index + 1)
    }
}

extension FixedWidthInteger where Self: CompactCodable, UI == Self {
    public static var compactBitWidth: Int { Self.bitWidth }
    public static var compactMax: UI { Self.max }
}

extension UInt8: CompactCodable, CompactConvertible {}
extension UInt16: CompactCodable, CompactConvertible {}
extension UInt32: CompactCodable, CompactConvertible {}
extension UInt64: CompactCodable, CompactConvertible {}
