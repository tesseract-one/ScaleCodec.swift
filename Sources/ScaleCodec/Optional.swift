//
//  Optional.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension Optional: ContainerEncodable {
    public typealias EElement = Wrapped
    
    public func encode<E: Encoder>(in encoder: inout E, writer: @escaping (EElement, inout E) throws -> Void) throws {
        if EElement.self == Bool.self {
            try encodeBool(encoder: &encoder, self as! Bool?)
        } else {
            switch self {
            case .none: try encoder.encode(UInt8(0x00))
            case .some(let val):
                try encoder.encode(UInt8(0x01))
                try writer(val, &encoder)
            }
        }
    }
}

extension Optional: Encodable where Wrapped: Encodable {}

extension Optional: ContainerDecodable {
    public typealias DElement = Wrapped
    
    public init<D: Decoder>(from decoder: inout D, reader: @escaping (inout D) throws -> DElement) throws {
        if DElement.self == Bool.self {
            self = try decodeBool(decoder: &decoder) as! DElement?
        } else {
            let val = try decoder.decode(UInt8.self)
            switch val {
            case 0x00: self = .none
            case 0x01: self = try .some(reader(&decoder))
            default:
                throw DecodingError.dataCorrupted(
                    DecodingError.Context(
                        path: decoder.path,
                        description: "Wrong Optional value: \(val)"
                    )
                )
            }
        }
    }
}

extension Optional: Decodable where Wrapped: Decodable {}

extension Optional: ContainerSizeCalculable {
    public typealias SElement = Wrapped
    
    public static func calculateSize<D: SkippableDecoder>(
        in decoder: inout D,
        esize: @escaping (inout D) throws -> Int
    ) throws -> Int {
        if DElement.self == Bool.self {
            try decoder.skip(count: 1)
            return 1
        }
        let val = try decoder.decode(UInt8.self)
        switch val {
        case 0x00: return 1
        case 0x01: return try esize(&decoder) + 1
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    path: decoder.path,
                    description: "Wrong Optional value: \(val)"
                )
            )
        }
    }
}

extension Optional: SizeCalculable where Wrapped: SizeCalculable {}

private func encodeBool<E: Encoder>(encoder: inout E, _ value: Bool?) throws {
    switch value {
    case .none: try encoder.encode(UInt8(0x00))
    case .some(let val): try encoder.encode(UInt8(val ? 0x01 : 0x02))
    }
}

private func decodeBool<D: Decoder>(decoder: inout D) throws -> Bool? {
    let val = try decoder.decode(UInt8.self)
    switch val {
    case 0x00: return nil
    case 0x01: return true
    case 0x02: return false
    default:
        throw DecodingError.dataCorrupted(
            DecodingError.Context(
                path: decoder.path,
                description: "Wrong Option<Bool> value \(val)"
            )
        )
    }
}
