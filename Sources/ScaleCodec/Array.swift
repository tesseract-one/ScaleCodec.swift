//
//  Array.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension Array: ScaleEncodable where Element: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try encoder.encodeCompact(UInt32(count))
        for element in self {
            try encoder.encode(element)
        }
    }
}

extension Array: ScaleDecodable where Element: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        let size = try Int(decoder.decodeCompact(UInt32.self))
        var array = Array<Element>()
        array.reserveCapacity(size)
        for _ in 0..<size {
            try array.append(decoder.decode())
        }
        self = array
    }
}
