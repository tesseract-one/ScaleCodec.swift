//
//  String.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension String: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        let data = try decoder.decode(Data.self)
        guard let str = String(data: data, encoding: .utf8) else {
            let hex = data.map { String(format: "%02x", $0) }.joined(separator: " ")
            throw SDecodingError.dataCorrupted(
                SDecodingError.Context(
                    path: decoder.path,
                    description: "Bad UTF8 string data: \(hex)"
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
        try encoder.encode(data)
    }
}
