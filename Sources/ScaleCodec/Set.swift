//
//  Set.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import Foundation

extension Set: ScaleContainerEncodable {
    public typealias EElement = Element
    
    public func encode(in encoder: ScaleEncoder, writer: @escaping (EElement, ScaleEncoder) throws -> Void) throws {
        let array = Array(self)
        try array.encode(in: encoder, writer: writer)
    }
}

extension Set: ScaleEncodable where Element: ScaleEncodable {}

extension Set: ScaleContainerDecodable {
    public typealias DElement = Element
    
    public init(from decoder: ScaleDecoder, reader: @escaping (ScaleDecoder) throws -> DElement) throws {
        let array = try Array<Element>(from: decoder, reader: reader)
        self = Set(array)
    }
}

extension Set: ScaleDecodable where Element: ScaleDecodable {}

extension Set: ScaleArrayInitializable {
    public typealias IElement = Element
    
    public init(array: [IElement]) {
        self.init(array)
    }
}

extension Set: ScaleArrayConvertible {
    public typealias CElement = Element
    
    public var asArray: [CElement] { Array(self) }
}
