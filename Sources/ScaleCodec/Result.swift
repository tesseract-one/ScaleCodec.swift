//
//  Result.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation


extension Result: ScaleDoubleContainerDecodable {
    public typealias DLeft = Success
    public typealias DRight = Failure
    
    public init(
        from decoder: ScaleDecoder,
        lreader: @escaping (ScaleDecoder) throws -> DLeft,
        rreader: @escaping (ScaleDecoder) throws -> DRight
    ) throws {
        let res = try decoder.decode(UInt8.self)
        switch res {
        case 0x00: self = try .success(lreader(decoder))
        case 0x01: self = try .failure(rreader(decoder))
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

extension Result: ScaleDoubleContainerEncodable {
    public typealias ELeft = Success
    public typealias ERight = Failure
    
    public func encode(
        in encoder: ScaleEncoder,
        lwriter: @escaping (Success, ScaleEncoder) throws -> Void,
        rwriter: @escaping (Failure, ScaleEncoder) throws -> Void
    ) throws {
        switch self {
        case .success(let val): try lwriter(val, encoder.encode(UInt8(0x00)))
        case .failure(let err): try rwriter(err, encoder.encode(UInt8(0x01)))
        }
    }
}

extension Result: ScaleContainerEncodable where Failure: ScaleEncodable {
    public typealias EElement = Success
}

extension Result: ScaleContainerDecodable where Failure: ScaleDecodable {
    public typealias DElement = Success
}

extension Result: ScaleEncodable where Success: ScaleEncodable, Failure: ScaleEncodable {}

extension Result: ScaleDecodable where Success: ScaleDecodable, Failure: ScaleDecodable {}
