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

extension FixedWidthInteger where Self: ScaleFixedData {
    public init(decoding data: Data) throws {
        self = data.withUnsafeBytes {
            $0.load(as: Self.self).littleEndian
        }
    }
    
    public func encode() throws -> Data {
        return withUnsafeBytes(of: self.littleEndian) { Data($0) }
    }
    
    public static var fixedBytesCount: Int { Self.bitWidth / 8 }
}

extension UInt8: ScaleFixedData {}
extension Int8: ScaleFixedData {}
extension UInt16: ScaleFixedData {}
extension Int16: ScaleFixedData {}
extension UInt32: ScaleFixedData {}
extension Int32: ScaleFixedData {}
extension UInt64: ScaleFixedData {}
extension Int64: ScaleFixedData {}
