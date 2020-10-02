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
        self = String(bytes: bytes, encoding: .utf8)!
    }
    
    public func encode(in encoder: ScaleEncoder) throws {
        let bytes = Array<UInt8>(self.data(using: .utf8)!)
        try encoder.encode(bytes)
    }
}
