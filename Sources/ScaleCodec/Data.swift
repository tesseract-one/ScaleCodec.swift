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
