//
//  Data.swift
//  
//
//  Created by Yehor Popovych on 10/5/20.
//

import Foundation

extension Data: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(UInt32(count), .compact)
        encoder.write(self)
    }
}

extension Data: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let count = try decoder.decode(UInt32.self, .compact)
        self = try decoder.readOrError(count: Int(count), type: Data.self)
    }
}

extension ScaleCustomDecoderFactory where T == Data {
    public static func fixed(_ size: UInt) -> ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { try $0.readOrError(count: Int(size), type: Data.self) }
    }
}

extension ScaleCustomEncoderFactory where T == Data {
    public static func fixed(_ size: UInt) -> ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { encoder, data in
            guard data.count == size else {
                throw SEncodingError.invalidValue(
                    data, SEncodingError.Context(
                        path: encoder.path,
                        description: "Wrong bytes count \(data.count) expected \(size)"
                    )
                )
            }
            encoder.write(data)
            return encoder
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
