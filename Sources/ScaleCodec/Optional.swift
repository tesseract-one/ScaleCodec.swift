//
//  Optional.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

public enum SOptBool {
    case none
    case some(Bool)

    public init(_ optional: Bool?) {
        switch optional {
        case .none: self = .none
        case .some(let val): self = .some(val)
        }
    }
    
    public init(_ bool: Bool) {
        self = .some(bool)
    }
    
    public var value: Bool? {
        switch self {
        case .none: return .none
        case .some(let val): return .some(val)
        }
    }
}

extension SOptBool: ScaleCodable {
    public init(from decoder: ScaleDecoder) throws {
        let val = try decoder.decode(UInt8.self)
        switch val {
        case 0x00: self = .none
        case 0x01: self = .some(false)
        case 0x02: self = .some(true)
        default:
            throw SDecodingError.dataCorrupted(
                SDecodingError.Context(
                    path: decoder.path,
                    description: "Wrong Option<Bool> value \(val)"
                )
            )
        }
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        switch self {
        case .none: try encoder.encode(UInt8(0x00))
        case .some(let val): try encoder.encode(UInt8(val ? 0x02 : 0x01))
        }
    }
}

extension Optional: ScaleEncodable where Wrapped: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        if type(of: self) == Optional<Bool>.self {
            throw SEncodingError.invalidValue(
                self,
                SEncodingError.Context(
                    path: encoder.path,
                    description: "Can't encode Optional<Bool> use SOptBool instead"
                )
            )
        }
        switch self {
        case .none:
            try encoder.encode(UInt8(0x00))
        case .some(let val):
            try encoder.encode(UInt8(0x01)).encode(val)
        }
    }
}


extension Optional: ScaleDecodable where Wrapped: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        if Wrapped.self == Bool.self {
            throw SDecodingError.typeMismatch(
                Bool.self,
                SDecodingError.Context(
                    path: decoder.path,
                    description: "Can't decode Optional<Bool> use SOptBool instead"
                )
            )
        }
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

extension ScaleDecoder {
    public func decodeOptBool() throws -> Bool? {
        return try self.decode(SOptBool.self).value
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encodeOptBool(_ value: Bool?) throws -> ScaleEncoder {
        return try self.encode(SOptBool(value))
    }
}
