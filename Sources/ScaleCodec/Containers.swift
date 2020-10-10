//
//  Collections.swift
//  
//
//  Created by Yehor Popovych on 10/10/20.
//

import Foundation

public protocol ScaleContainerEncodable {
    associatedtype EElement
    
    func encode(in encoder: ScaleEncoder, writer: @escaping (EElement, ScaleEncoder) throws -> Void) throws
}

public protocol ScaleContainerDecodable {
    associatedtype DElement
    
    init(from decoder: ScaleDecoder, reader: @escaping (ScaleDecoder) throws -> DElement) throws
}

extension ScaleContainerEncodable where EElement: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder) throws {
        try self.encode(in: encoder) { val, enc in
            try enc.encode(val)
        }
    }
}

extension ScaleContainerDecodable where DElement: ScaleDecodable {
    public init(from decoder: ScaleDecoder) throws {
        try self.init(from: decoder) { try $0.decode() }
    }
}

public protocol ScaleDoubleContainerEncodable {
    associatedtype ELeft
    associatedtype ERight
    
    func encode(
        in encoder: ScaleEncoder,
        lwriter: @escaping (ELeft, ScaleEncoder) throws -> Void,
        rwriter: @escaping (ERight, ScaleEncoder) throws -> Void
    ) throws
}

public protocol ScaleDoubleContainerDecodable {
    associatedtype DLeft
    associatedtype DRight
    
    init(
        from decoder: ScaleDecoder,
        lreader: @escaping (ScaleDecoder) throws -> DLeft,
        rreader: @escaping (ScaleDecoder) throws -> DRight
    ) throws
}

extension ScaleDoubleContainerEncodable where ELeft: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder, writer: @escaping (ERight, ScaleEncoder) throws -> Void) throws {
        try encode(in: encoder, lwriter: { val, enc in try enc.encode(val) }, rwriter: writer)
    }
}

extension ScaleDoubleContainerEncodable where ERight: ScaleEncodable {
    public func encode(in encoder: ScaleEncoder, writer: @escaping (ELeft, ScaleEncoder) throws -> Void) throws {
        try encode(in: encoder, lwriter: writer, rwriter: { val, enc in try enc.encode(val) })
    }
}

extension ScaleDoubleContainerDecodable where DLeft: ScaleDecodable {
    public init(from decoder: ScaleDecoder, reader: @escaping (ScaleDecoder) throws -> DRight) throws {
        try self.init(from: decoder, lreader: { try $0.decode() }, rreader: reader)
    }
}

extension ScaleDoubleContainerDecodable where DRight: ScaleDecodable {
    public init(from decoder: ScaleDecoder, reader: @escaping (ScaleDecoder) throws -> DLeft) throws {
        try self.init(from: decoder, lreader: reader, rreader: { try $0.decode() })
    }
}

