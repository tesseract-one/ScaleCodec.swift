//
//  Integers.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

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
        self = try decoder.readOrError(count: 1, type: UInt8.self).first!
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        encoder.write(Data([self]))
    }
}

extension Int8: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        let uint = try decoder.readOrError(count: 1, type: Int8.self).first!
        self = Int8(bitPattern: uint)
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        let uint = UInt8(bitPattern: self)
        encoder.write(Data([uint]))
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
            encoder.write(Data($0))
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
            encoder.write(Data($0))
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
            encoder.write(Data($0))
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
            encoder.write(Data($0))
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
            encoder.write(Data($0))
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
            encoder.write(Data($0))
        }
    }
}
