//
//  Integers.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation
import BigInt

extension Bool: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        let val = try decoder.decode(UInt8.self)
        switch val {
        case 0x00: self = false
        case 0x01: self = true
        default:
            throw SDecodingError.dataCorrupted(
                SDecodingError.Context(
                    path: decoder.path,
                    description: "Wrong Bool value: \(val)"
                )
            )
        }
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(UInt8(self ? 0x01: 0x00))
    }
}

extension UInt8: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        self = try decoder.readOrError(count: 1, type: UInt8.self)[0]
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        encoder.write([self])
    }
}

extension Int8: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        let uint = try decoder.readOrError(count: 1, type: Int8.self)[0]
        self = Int8(bitPattern: uint)
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        let uint = UInt8(bitPattern: self)
        encoder.write([uint])
    }
}

extension UInt16: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        self = try decoder.readOrError(count: 2, type: UInt16.self).withUnsafeBytes {
            $0.load(as: UInt16.self).littleEndian
        }
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        withUnsafeBytes(of: self.littleEndian) {
            encoder.write(Array($0))
        }
    }
}

extension Int16: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        self = try decoder.readOrError(count: 2, type: Int16.self).withUnsafeBytes {
            $0.load(as: Int16.self).littleEndian
        }
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        withUnsafeBytes(of: self.littleEndian) {
            encoder.write(Array($0))
        }
    }
}

extension UInt32: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        self = try decoder.readOrError(count: 4, type: UInt32.self).withUnsafeBytes {
            $0.load(as: UInt32.self).littleEndian
        }
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        withUnsafeBytes(of: self.littleEndian) {
            encoder.write(Array($0))
        }
    }
}

extension Int32: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        self = try decoder.readOrError(count: 4, type: Int32.self).withUnsafeBytes {
            $0.load(as: Int32.self).littleEndian
        }
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        withUnsafeBytes(of: self.littleEndian) {
            encoder.write(Array($0))
        }
    }
}

extension UInt64: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        self = try decoder.readOrError(count: 8, type: UInt64.self).withUnsafeBytes {
            $0.load(as: UInt64.self).littleEndian
        }
    }

    public func encode(in encoder: ScaleEncoder) throws {
        withUnsafeBytes(of: self.littleEndian) {
            encoder.write(Array($0))
        }
    }
}

extension Int64: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        self = try decoder.readOrError(count: 8, type: Int64.self).withUnsafeBytes {
            $0.load(as: Int64.self).littleEndian
        }
    }

    public func encode(in encoder: ScaleEncoder) throws {
        withUnsafeBytes(of: self.littleEndian) {
            encoder.write(Array($0))
        }
    }
}

extension BigUInt: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        let bytes = try decoder.readOrError(count: 16, type: BigUInt.self)
        self = BigUInt(Data(bytes.reversed()))
    }

    public func encode(in encoder: ScaleEncoder) throws {
        guard self <= UINT128_MAX else {
            throw SEncodingError.invalidValue(
                self,
                SEncodingError.Context(
                    path: encoder.path,
                    description: "Value is too big. Max value is 2^128-1. Use compact encoding."
                )
            )
        }
        self.serialize().withUnsafeBytes { bytes in
            var data: [UInt8] = bytes.reversed()
            let zeroes = 16 - data.count
            if zeroes > 0 {
                data = Array<UInt8>(repeating: 0x00, count: zeroes) + data
            }
            encoder.write(data)
        }
    }
}

extension BigInt: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        let buint = try decoder.decode(BigUInt.self)
        self = buint > INT128_MAX
            ? BigInt(sign: .minus, magnitude: (INT128_OF - BigInt(buint)).magnitude)
            : BigInt(sign: .plus, magnitude: buint)
    }

    public func encode(in encoder: ScaleEncoder) throws {
        switch sign {
        case .minus:
            guard self >= INT128_MIN else {
                throw SEncodingError.invalidValue(
                    self,
                    SEncodingError.Context(
                        path: encoder.path,
                        description: "Value is too small. Min value is -2^127."
                    )
                )
            }
            try encoder.encode((INT128_OF + self).magnitude)
        case .plus:
            guard self <= INT128_MAX else {
                throw SEncodingError.invalidValue(
                    self,
                    SEncodingError.Context(
                        path: encoder.path,
                        description: "Value is too big. Max value is 2^127-1. Use compact encoding."
                    )
                )
            }
            try encoder.encode(self.magnitude)
        }
    }
}

private let UINT128_MAX: BigUInt = BigUInt(2).power(128) - 1
private let INT128_MAX: BigInt = BigInt(2).power(127) - 1
private let INT128_MIN: BigInt = BigInt(-2).power(127)
private let INT128_OF: BigInt = BigInt(2).power(128)
