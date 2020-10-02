//
//  Set.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import Foundation

extension Set: ScaleEncodable where Element: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(Array(self))
    }
}

extension Set: ScaleDecodable where Element: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let array = try decoder.decode(Array<Element>.self)
        self = Set(array)
    }
}
