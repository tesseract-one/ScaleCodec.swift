//
//  String.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension String: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        let bytes = try decoder.decode(Array<UInt8>.self)
        guard let str = String(bytes: bytes, encoding: .utf8) else {
            throw SDecodingError.dataCorrupted(
                SDecodingError.Context(
                    path: decoder.path,
                    description: "Bad UTF8 string data: \(bytes)"
                )
            )
        }
        self = str
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        guard let data = self.data(using: .utf8) else {
            throw SEncodingError.invalidValue(
                self,
                SEncodingError.Context(
                    path: encoder.path,
                    description: "Can't be encoded to UTF8: \(self)"
                )
            )
        }
        let bytes = Array<UInt8>(data)
        try encoder.encode(bytes)
    }
}
