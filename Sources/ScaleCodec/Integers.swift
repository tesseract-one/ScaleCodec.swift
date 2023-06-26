//
//  Integers.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension Bool: Codable, SizeCalculable {
    public init<D: Decoder>(from decoder: inout D) throws {
        let val = try decoder.decode(UInt8.self)
        switch val {
        case 0x00: self = false
        case 0x01: self = true
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    path: decoder.path,
                    description: "Wrong Bool value: \(val)"
                )
            )
        }
    }
    
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(UInt8(self ? 0x01: 0x00))
    }
    
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try decoder.skip(count: 1)
        return 1
    }
}

extension FixedWidthInteger {
    public init?(data: Data, littleEndian: Bool, trimmed: Bool) {
        guard data.count <= Self.bitWidth / 8 else {
            return nil
        }
        var data = data
        if (trimmed) {
            data.ensureSize(expected: Self.bitWidth / 8, leading: !littleEndian)
        }
        self = data.withUnsafeBytes {
            let value = $0.load(as: Self.self)
            return littleEndian ? value.littleEndian : value.bigEndian
        }
    }
    
    public func data(littleEndian: Bool, trimmed: Bool) -> Data {
        let data = withUnsafeBytes(
            of: littleEndian ? self.littleEndian : self.bigEndian
        ) { Data($0) }
        return trimmed ? data.trimming(leading: !littleEndian) : data
    }
}

extension FixedWidthInteger where Self: FixedDataCodable & DataConvertible {
    public init(decoding data: Data) throws {
        self.init(data: data, littleEndian: true, trimmed: false)!
    }
    
    public func serialize() -> Data {
        data(littleEndian: true, trimmed: false)
    }
    
    public static var fixedBytesCount: Int { Self.bitWidth / 8 }
}

extension UInt8: FixedDataCodable, DataConvertible, SizeCalculable {}
extension Int8: FixedDataCodable, DataConvertible, SizeCalculable {}
extension UInt16: FixedDataCodable, DataConvertible, SizeCalculable {}
extension Int16: FixedDataCodable, DataConvertible, SizeCalculable {}
extension UInt32: FixedDataCodable, DataConvertible, SizeCalculable {}
extension Int32: FixedDataCodable, DataConvertible, SizeCalculable {}
extension UInt64: FixedDataCodable, DataConvertible, SizeCalculable {}
extension Int64: FixedDataCodable, DataConvertible, SizeCalculable {}
