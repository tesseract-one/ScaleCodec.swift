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

extension UInt8: ScaleFixedData {
    public init(decoding data: Data) throws {
        self = data.first!
    }
    
    public func encode() throws -> Data {
        return Data(repeating: self, count: 1)
    }
    
    public static var fixedBytesCount: Int = 1
}

extension Int8: ScaleFixedData {
    public init(decoding data: Data) throws {
        self = Int8(bitPattern: data.first!)
    }
    
    public func encode() throws -> Data {
        let uint = UInt8(bitPattern: self)
        return Data(repeating: uint, count: 1)
    }
    
    public static var fixedBytesCount: Int = 1
}

extension UInt16: ScaleFixedData {
    public init(decoding data: Data) throws {
        self = data.withUnsafeBytes {
            $0.load(as: UInt16.self).littleEndian
        }
    }
    
    public func encode() throws -> Data {
        return withUnsafeBytes(of: self.littleEndian) { Data($0) }
    }
    
    public static var fixedBytesCount: Int = 2
}

extension Int16: ScaleFixedData {
    public init(decoding data: Data) throws {
        self = data.withUnsafeBytes {
            $0.load(as: Int16.self).littleEndian
        }
    }
    
    public func encode() throws -> Data {
        return withUnsafeBytes(of: self.littleEndian) { Data($0) }
    }
    
    public static var fixedBytesCount: Int = 2
}

extension UInt32: ScaleFixedData {
    public init(decoding data: Data) throws {
        self = data.withUnsafeBytes {
            $0.load(as: UInt32.self).littleEndian
        }
    }
    
    public func encode() throws -> Data {
        return withUnsafeBytes(of: self.littleEndian) { Data($0) }
    }
    
    public static var fixedBytesCount: Int = 4
}

extension Int32: ScaleFixedData {
    public init(decoding data: Data) throws {
        self = data.withUnsafeBytes {
            $0.load(as: Int32.self).littleEndian
        }
    }
    
    public func encode() throws -> Data {
        return withUnsafeBytes(of: self.littleEndian) { Data($0) }
    }
    
    public static var fixedBytesCount: Int = 4
}

extension UInt64: ScaleFixedData {
    public init(decoding data: Data) throws {
        self = data.withUnsafeBytes {
            $0.load(as: UInt64.self).littleEndian
        }
    }
    
    public func encode() throws -> Data {
        return withUnsafeBytes(of: self.littleEndian) { Data($0) }
    }
    
    public static var fixedBytesCount: Int = 8
}

extension Int64: ScaleFixedData {
    public init(decoding data: Data) throws {
        self = data.withUnsafeBytes {
            $0.load(as: Int64.self).littleEndian
        }
    }
    
    public func encode() throws -> Data {
        return withUnsafeBytes(of: self.littleEndian) { Data($0) }
    }
    
    public static var fixedBytesCount: Int = 8
}
