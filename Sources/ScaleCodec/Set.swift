//
//  Set.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import Foundation

extension Set: ContainerEncodable {
    public typealias EElement = Element
    
    public func encode<E: Encoder>(in encoder: inout E, writer: @escaping (EElement, inout E) throws -> Void) throws {
        let array = Array(self)
        try array.encode(in: &encoder, writer: writer)
    }
}

extension Set: Encodable where Element: Encodable {}

extension Set: ContainerDecodable {
    public typealias DElement = Element
    
    public init<D: Decoder>(from decoder: inout D, reader: @escaping (inout D) throws -> DElement) throws {
        let array = try Array<Element>(from: &decoder, reader: reader)
        self = Set(array)
    }
}

extension Set: Decodable where Element: Decodable {}

extension Set: ArrayInitializable {
    public typealias IElement = Element
    
    public init(array: [IElement]) {
        self.init(array)
    }
}

extension Set: ArrayConvertible {
    public typealias CElement = Element
    
    public var asArray: [CElement] { Array(self) }
}

extension Set: ContainerSizeCalculable {
    public typealias SElement = Element
    
    public static func calculateSize<D: SkippableDecoder>(
        in decoder: inout D,
        esize: @escaping (inout D) throws -> Int
    ) throws -> Int {
        try Array<Element>.calculateSize(in: &decoder, esize: esize)
    }
}
