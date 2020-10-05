//
//  Array.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension Array: ScaleEncodable where Element: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(compact: UInt32(count))
        for element in self {
            try encoder.encode(element)
        }
    }
}

extension Array: ScaleDecodable where Element: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let size = try Int(decoder.decode(UInt32.self, .compact))
        var array = Array<Element>()
        array.reserveCapacity(size)
        for _ in 0..<size {
            try array.append(decoder.decode())
        }
        self = array
    }
}

extension ScaleDecoder {
    public func decode<T: ScaleDecodable>(_ type: [T].Type, _ fixed: ScaleFixedTypeMarker) throws -> [T] {
        return try self.decode(fixed)
    }
    
    public func decode<T: ScaleDecodable>(_ fixed: ScaleFixedTypeMarker) throws -> [T] {
        guard case .fixed(let size) = fixed else { fatalError() } // Compiler error silencing.
        var values = Array<T>()
        values.reserveCapacity(Int(size))
        for _ in 0..<size {
            try values.append(self.decode())
        }
        return values
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T: ScaleEncodable>(_ values: [T], fixed: UInt) throws -> ScaleEncoder {
        guard values.count == fixed else {
            throw SEncodingError.invalidValue(
                values, SEncodingError.Context(
                    path: self.path,
                    description: "Wrong value count \(values.count) expected \(fixed)"
                )
            )
        }
        for val in values {
            try self.encode(val)
        }
        return self
    }
}

extension SCALE {
    public func decode<T: ScaleDecodable>(_ type: [T].Type, _ fixed: ScaleFixedTypeMarker, from data: Data) throws -> [T] {
        return try self.decode(fixed, from: data)
    }
    
    public func decode<T: ScaleDecodable>(_ fixed: ScaleFixedTypeMarker, from data: Data) throws -> [T] {
        return try self.decoder(data: data).decode(fixed)
    }
    
    public func encode<T: ScaleEncodable>(_ values: [T], fixed: UInt) throws -> Data {
        return try self.encoder().encode(values, fixed: fixed).output
    }
}
