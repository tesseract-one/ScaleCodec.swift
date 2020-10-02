//
//  Compact.swift
//  
//
//  Created by Yehor Popovych on 9/30/20.
//

import Foundation
@_exported import BigInt

private let SCOMPACT_MAX_VALUE = BigUInt(2).power(536) - 1

public struct SCompact<T: UnsignedInteger> {
    public let value: T;
    
    public init(_ value: T) {
        self.value = value
    }
    
    static var MAX_VALUE: BigUInt {
        return SCOMPACT_MAX_VALUE
    }
}

extension SCompact: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        switch value {
        case 0x00...0x3f: try encoder.encode(UInt8(value) << 2)
        case 0x40...0x3fff: try encoder.encode(UInt16(value) << 2 | 0b01)
        case 0x4000...0x3fffffff: try encoder.encode(UInt32(value) << 2 | 0b10)
        default: // BigUInt
            let buint = value as? BigUInt ?? BigUInt(value)
            if buint > SCompact.MAX_VALUE {
                throw SEncodingError.invalidValue(
                    self,
                    SEncodingError.Context(
                        path: encoder.path,
                        description: "Value is too big: \(buint)"
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
            try checkSize(T.self, bytes: 2, decoder: decoder)
            value = try T(decoder.decode(UInt16.self) >> 2)
        case 0b10:
            try checkSize(T.self, bytes: 4, decoder: decoder)
            value = try T(decoder.decode(UInt32.self) >> 2)
        case 0b11:
            let len = try decoder.readOrError(count: 1, type: type(of: self))[0] >> 2 + 4
            let bytes = try decoder.readOrError(count: Int(len), type: type(of: self))
            try checkSize(T.self, bytes: len, decoder: decoder)
            value = T(BigUInt(Data(bytes.reversed())))
        default: fatalError() // Only to silence compiler error
        }
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encodeCompact<T: UnsignedInteger>(_ value: T) throws -> ScaleEncoder {
        return try self.encode(SCompact(value))
    }
}

extension ScaleDecoder {
    public func decodeCompact<T: UnsignedInteger>(_ type: T.Type) throws -> T {
        return try self.decode(SCompact<T>.self).value
    }
    
    public func decodeCompact<T: UnsignedInteger>() throws -> T {
        return try self.decodeCompact(T.self)
    }
}

private func checkSize<T: UnsignedInteger>(_ type: T.Type, bytes: UInt8, decoder: ScaleDecoder) throws {
    if type != BigUInt.self && MemoryLayout<T>.size < bytes {
        throw SDecodingError.typeMismatch(
            type,
            SDecodingError.Context(
                path: decoder.path,
                description: "Can't store \(bytes) bytes of data in \(type)"
            )
        )
    }
}
