//
//  Data.swift
//  
//
//  Created by Yehor Popovych on 10/5/20.
//

import Foundation

extension Data: Encodable {
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try encoder.encode(UInt32(count), .compact)
        encoder.write(self)
    }
}

extension Data: Decodable {
    public init<D: Decoder>(from decoder: inout D) throws {
        let count = try decoder.decode(UInt32.self, .compact)
        self = try decoder.read(count: Int(count))
    }
}

extension Data: SizeCalculable {
    public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        let cSize = try Compact<UInt32>.calculateSizeNoSkip(in: &decoder)
        let count = try Int(decoder.decode(UInt32.self, .compact))
        try decoder.skip(count: count)
        return count + cSize
    }
}

extension CustomDecoderFactory where T == Data {
    public static func fixed(_ size: UInt) -> CustomDecoderFactory {
        CustomDecoderFactory { try $0.read(count: Int(size)) }
    }
}

extension CustomEncoderFactory where T == Data {
    public static func fixed(_ size: UInt) -> CustomEncoderFactory {
        CustomEncoderFactory { encoder, data in
            guard data.count == size else {
                throw EncodingError.invalidValue(
                    data, EncodingError.Context(
                        path: encoder.path,
                        description: "Wrong bytes count \(data.count) expected \(size)"
                    )
                )
            }
            encoder.write(data)
        }
    }
}

public protocol DataSerializable {
    func data(littleEndian: Bool, trimmed: Bool) -> Data
}

public protocol DataInitalizable {
    init?(data: Data, littleEndian: Bool, trimmed: Bool)
}

public typealias DataConvertible = DataInitalizable & DataSerializable

extension Data {
    public mutating func trim(leading: Bool, value: UInt8 = 0) {
        if leading {
            guard let index = firstIndex(where: { $0 != value }) else {
                return
            }
            removeFirst(index)
        } else {
            guard let index = lastIndex(where: { $0 != value }) else {
                return
            }
            removeLast(count - index - 1)
        }
    }
    
    public func trimming(leading: Bool, value: UInt8 = 0) -> Data {
        var data = self
        data.trim(leading: leading, value: value)
        return data
    }
    
    public mutating func ensureSize(
        expected size: Int,
        leading: Bool,
        fill byte: UInt8 = 0
    ) {
        guard count < size else { return }
        let fill = Data(repeating: byte, count: size - count)
        leading ? insert(contentsOf: fill, at: 0) : append(contentsOf: fill)
    }
    
    public func ensuringSize(
        expected size: Int,
        leading: Bool,
        fill byte: UInt8 = 0
    ) -> Data {
        guard count < size else { return self }
        var data = self
        data.ensureSize(expected: size, leading: leading, fill: byte)
        return data
    }
}
