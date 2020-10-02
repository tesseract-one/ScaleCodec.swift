//
//  Optional.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension Optional: ScaleEncodable where Wrapped: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        if Wrapped.self == Bool.self {
            try encodeBool(encoder: encoder, self as! Bool?)
        } else {
            switch self {
            case .none: try encoder.encode(UInt8(0x00))
            case .some(let val): try encoder.encode(UInt8(0x01)).encode(val)
            }
        }
    }
}

extension Optional: ScaleDecodable where Wrapped: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        if Wrapped.self == Bool.self {
            self = try decodeBool(decoder: decoder) as! Wrapped?
        } else {
            let val = try decoder.decode(UInt8.self)
            switch val {
            case 0x00: self = .none
            case 0x01: self = try .some(decoder.decode())
            default:
                throw SDecodingError.dataCorrupted(
                    SDecodingError.Context(
                        path: decoder.path,
                        description: "Wrong Optional value: \(val)"
                    )
                )
            }
        }
    }
}

private func encodeBool(encoder: ScaleEncoder, _ value: Bool?) throws {
    switch value {
    case .none: try encoder.encode(UInt8(0x00))
    case .some(let val): try encoder.encode(UInt8(val ? 0x02 : 0x01))
    }
}

private func decodeBool(decoder: ScaleDecoder) throws -> Bool? {
    let val = try decoder.decode(UInt8.self)
    switch val {
    case 0x00: return nil
    case 0x01: return false
    case 0x02: return true
    default:
        throw SDecodingError.dataCorrupted(
            SDecodingError.Context(
                path: decoder.path,
                description: "Wrong Option<Bool> value \(val)"
            )
        )
    }
}
