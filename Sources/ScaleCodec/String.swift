//
//  String.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension String: Codable {
    public init<D: Decoder>(from decoder: inout D) throws {
        let data = try decoder.decode(Data.self)
        guard let str = String(data: data, encoding: .utf8) else {
            let hex = data.map { String(format: "%02x", $0) }.joined(separator: " ")
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    path: decoder.path,
                    description: "Bad UTF8 string data: \(hex)"
                )
            )
        }
        self = str
    }
    
    public func encode<E: Encoder>(in encoder: inout E) throws {
        guard let data = self.data(using: .utf8) else {
            throw EncodingError.invalidValue(
                self,
                EncodingError.Context(
                    path: encoder.path,
                    description: "Can't be encoded to UTF8: \(self)"
                )
            )
        }
        try encoder.encode(data)
    }
}

extension String: SizeCalculable {
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try Data.calculateSize(in: &decoder)
    }
}

extension Character: Codable {
    public init<D: Decoder>(from decoder: inout D) throws {
        let value = try decoder.decode(UInt32.self)
        guard let scalar = UnicodeScalar(value) else {
            throw DecodingError.dataCorrupted(
                decoder.errorContext("Bad character data: \(value)")
            )
        }
        self.init(scalar)
    }
    
    public func encode<E: Encoder>(in encoder: inout E) throws {
        guard unicodeScalars.count == 1 else {
            throw EncodingError.invalidValue(
                self,
                encoder.errorContext("Bad character value. Has \(unicodeScalars.count) scalars")
            )
        }
        try encoder.encode(unicodeScalars.first!.value)
    }
}

extension Character: SizeCalculable {
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try UInt32.calculateSize(in: &decoder)
    }
}
