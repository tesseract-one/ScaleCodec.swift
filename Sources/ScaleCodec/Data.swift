//
//  Data.swift
//  
//
//  Created by Yehor Popovych on 10/5/20.
//

import Foundation

extension Data: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(Array<UInt8>(self))
    }
}

extension Data: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        self = Data(try decoder.decode(Array<UInt8>.self))
    }
}
