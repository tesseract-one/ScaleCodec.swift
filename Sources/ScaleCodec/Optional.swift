//
//  Optional.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension Optional: ScaleContainerEncodable {
    public typealias EElement = Wrapped
    
    public func encode(in encoder: ScaleEncoder, writer: @escaping (EElement, ScaleEncoder) throws -> Void) throws {
        if EElement.self == Bool.self {
            try encodeBool(encoder: encoder, self as! Bool?)
        } else {
            switch self {
            case .none: try encoder.encode(UInt8(0x00))
            case .some(let val): try writer(val, encoder.encode(UInt8(0x01)))
            }
        }
    }
}

extension Optional: ScaleEncodable where Wrapped: ScaleEncodable {}

extension Optional: ScaleContainerDecodable {
    public typealias DElement = Wrapped
    
    public init(from decoder: ScaleDecoder, reader: @escaping (ScaleDecoder) throws -> DElement) throws {
        if DElement.self == Bool.self {
            self = try decodeBool(decoder: decoder) as! DElement?
        } else {
            let val = try decoder.decode(UInt8.self)
            switch val {
            case 0x00: self = .none
            case 0x01: self = try .some(reader(decoder))
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

extension Optional: ScaleDecodable where Wrapped: ScaleDecodable {}

private func encodeBool(encoder: ScaleEncoder, _ value: Bool?) throws {
    switch value {
    case .none: try encoder.encode(UInt8(0x00))
    case .some(let val): try encoder.encode(UInt8(val ? 0x01 : 0x02))
    }
}

private func decodeBool(decoder: ScaleDecoder) throws -> Bool? {
    let val = try decoder.decode(UInt8.self)
    switch val {
    case 0x00: return nil
    case 0x01: return true
    case 0x02: return false
    default:
        throw SDecodingError.dataCorrupted(
            SDecodingError.Context(
                path: decoder.path,
                description: "Wrong Option<Bool> value \(val)"
            )
        )
    }
}
