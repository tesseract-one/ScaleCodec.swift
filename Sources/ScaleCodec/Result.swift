//
//  Result.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension Result: ScaleEncodable where Success: ScaleEncodable, Failure: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        switch self {
        case .failure(let err):
            try encoder.encode(UInt8(0x01)).encode(err)
        case .success(let val):
            try encoder.encode(UInt8(0x00)).encode(val)
        }
    }
}

extension Result: ScaleDecodable where Success: ScaleDecodable, Failure: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let res = try decoder.decode(UInt8.self)
        switch res {
        case 0x00: self = try .success(decoder.decode())
        case 0x01: self = try .failure(decoder.decode())
        default:
            throw SDecodingError.dataCorrupted(
                SDecodingError.Context(
                    path: decoder.path,
                    description: "Wrong Result value: \(res)"
                )
            )
        }
    }
}
