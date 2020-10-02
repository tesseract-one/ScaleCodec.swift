//
//  Dictionary.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import Foundation

extension Dictionary: ScaleEncodable where Key: ScaleEncodable, Value: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(self.map { STuple($0) })
    }
}

extension Dictionary: ScaleDecodable where Key: ScaleDecodable, Value: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let array = try decoder.decode(Array<STuple2<Key, Value>>.self).map { $0.tuple }
        self = Dictionary(uniqueKeysWithValues: array)
    }
}
