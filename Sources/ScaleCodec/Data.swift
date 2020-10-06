//
//  Data.swift
//  
//
//  Created by Yehor Popovych on 10/5/20.
//

import Foundation

extension Data: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(compact: UInt32(count))
        encoder.write(self)
    }
}

extension Data: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let count = try decoder.decode(UInt32.self, .compact)
        self = try decoder.readOrError(count: Int(count), type: Data.self)
    }
}

extension ScaleDecoder {
    public func decode(_ type: Data.Type, _ fixed: ScaleFixedTypeMarker) throws -> Data {
        return try self.decode(fixed)
    }
    
    public func decode(_ fixed: ScaleFixedTypeMarker) throws -> Data {
        guard case .fixed(let size) = fixed else { fatalError() } // compiler error silencing.
        return try self.readOrError(count: Int(size), type: Data.self)
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encode(_ data: Data, fixed: UInt) throws -> ScaleEncoder {
        guard data.count == fixed else {
            throw SEncodingError.invalidValue(
                data, SEncodingError.Context(
                    path: self.path,
                    description: "Wrong bytes count \(data.count) expected \(fixed)"
                )
            )
        }
        self.write(data)
        return self
    }
}
