//
//  Result.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation


extension Result: DoubleContainerDecodable {
    public typealias DLeft = Success
    public typealias DRight = Failure
    
    public init<D: Decoder>(
        from decoder: inout D,
        lreader: @escaping (inout D) throws -> DLeft,
        rreader: @escaping (inout D) throws -> DRight
    ) throws {
        let res = try decoder.decode(UInt8.self)
        switch res {
        case 0x00: self = try .success(lreader(&decoder))
        case 0x01: self = try .failure(rreader(&decoder))
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    path: decoder.path,
                    description: "Wrong Result value: \(res)"
                )
            )
        }
    }
}

extension Result: DoubleContainerEncodable {
    public typealias ELeft = Success
    public typealias ERight = Failure
    
    public func encode<E: Encoder>(
        in encoder: inout E,
        lwriter: @escaping (Success, inout E) throws -> Void,
        rwriter: @escaping (Failure, inout E) throws -> Void
    ) throws {
        switch self {
        case .success(let val):
            try encoder.encode(UInt8(0x00))
            try lwriter(val, &encoder)
        case .failure(let err):
            try encoder.encode(UInt8(0x01))
            try rwriter(err, &encoder)
        }
    }
}

extension Result: ContainerEncodable where Failure: Encodable {
    public typealias EElement = Success
}

extension Result: ContainerDecodable where Failure: Decodable {
    public typealias DElement = Success
}

extension Result: Encodable where Success: Encodable, Failure: Encodable {}

extension Result: Decodable where Success: Decodable, Failure: Decodable {}

extension Result: DoubleContainerSizeCalculable {
    public typealias SLeft = Success
    public typealias SRight = Failure
    
    public static func calculateSize<D: SkippableDecoder>(
        in decoder: inout D,
        lsize: @escaping (inout D) throws -> Int,
        rsize: @escaping (inout D) throws -> Int
    ) throws -> Int {
        let res = try decoder.decode(UInt8.self)
        switch res {
        case 0x00: return try lsize(&decoder) + 1
        case 0x01: return try rsize(&decoder) + 1
        default:
            throw DecodingError.dataCorrupted(
                DecodingError.Context(
                    path: decoder.path,
                    description: "Wrong Result value: \(res)"
                )
            )
        }
    }
}

extension Result: ContainerSizeCalculable where Failure: SizeCalculable {
    public typealias SElement = Success
}

extension Result: SizeCalculable where Success: SizeCalculable, Failure: SizeCalculable {}
