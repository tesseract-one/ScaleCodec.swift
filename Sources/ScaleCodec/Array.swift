//
//  Array.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension Array: ScaleContainerEncodable {
    public typealias EElement = Element
    
    public func encode(in encoder: ScaleEncoder, writer: @escaping (EElement, ScaleEncoder) throws -> Void) throws {
        try encoder.encode(compact: UInt32(count))
        for element in self {
            try writer(element, encoder)
        }
    }
}

extension Array: ScaleContainerDecodable {
    public typealias DElement = Element
    
    public init(from decoder: ScaleDecoder, reader: @escaping (ScaleDecoder) throws -> Element) throws {
        let size = try Int(decoder.decode(UInt32.self, .compact))
        var array = Array<Element>()
        array.reserveCapacity(size)
        for _ in 0..<size {
            try array.append(reader(decoder))
        }
        self = array
    }
}

extension Array: ScaleEncodable where Element: ScaleEncodable {}

extension Array: ScaleDecodable where Element: ScaleDecodable {}

extension ScaleDecoder {
    public func decode<T: ScaleDecodable>(_ type: [T].Type, _ fixed: ScaleFixedTypeMarker) throws -> [T] {
        return try self.decode(fixed)
    }
    
    public func decode<T>(
        _ type: [T].Type, _ fixed: ScaleFixedTypeMarker,
        reader: @escaping (ScaleDecoder) throws -> T
    ) throws -> [T] {
        return try self.decode(fixed, reader: reader)
    }
    
    public func decode<T>(
        _ fixed: ScaleFixedTypeMarker,
        reader: @escaping (ScaleDecoder) throws -> T
    ) throws -> [T] {
        guard case .fixed(let size) = fixed else { fatalError() } // Compiler error silencing.
        var values = Array<T>()
        values.reserveCapacity(Int(size))
        for _ in 0..<size {
            try values.append(reader(self))
        }
        return values
    }
    
    public func decode<T: ScaleDecodable>(_ fixed: ScaleFixedTypeMarker) throws -> [T] {
        try self.decode(fixed) { decoder in try decoder.decode() }
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode<T: ScaleEncodable>(_ values: [T], fixed: UInt) throws -> ScaleEncoder {
        try self.encode(values, fixed: fixed) { val, enc in try enc.encode(val) }
        return self
    }
    
    @discardableResult
    public func encode<T>(
        _ values: [T], fixed: UInt,
        writer: @escaping (T, ScaleEncoder) throws -> Void
    ) throws -> ScaleEncoder {
        guard values.count == fixed else {
            throw SEncodingError.invalidValue(
                values, SEncodingError.Context(
                    path: self.path,
                    description: "Wrong value count \(values.count) expected \(fixed)"
                )
            )
        }
        for val in values {
            try writer(val, self)
        }
        return self
    }
}

extension SCALE {
    public func decode<T: ScaleDecodable>(
        _ type: [T].Type, _ fixed: ScaleFixedTypeMarker, from data: Data
    ) throws -> [T] {
        return try self.decode(fixed, from: data)
    }
    
    public func decode<T>(
        _ type: [T].Type, _ fixed: ScaleFixedTypeMarker, from data: Data,
        reader: @escaping (ScaleDecoder) throws -> T
    ) throws -> [T] {
        return try self.decode(fixed, from: data, reader: reader)
    }
    
    public func decode<T: ScaleDecodable>(_ fixed: ScaleFixedTypeMarker, from data: Data) throws -> [T] {
        return try self.decoder(data: data).decode(fixed)
    }
    
    public func decode<T>(
        _ fixed: ScaleFixedTypeMarker, from data: Data,
        reader: @escaping (ScaleDecoder) throws -> T
    ) throws -> [T] {
        return try self.decoder(data: data).decode(fixed, reader: reader)
    }
    
    public func encode<T: ScaleEncodable>(_ values: [T], fixed: UInt) throws -> Data {
        return try self.encoder().encode(values, fixed: fixed).output
    }
    
    public func encode<T>(
        _ values: [T], fixed: UInt,
        writer: @escaping (T, ScaleEncoder) throws -> Void
    ) throws -> Data {
        return try self.encoder().encode(values, fixed: fixed, writer: writer).output
    }
}
