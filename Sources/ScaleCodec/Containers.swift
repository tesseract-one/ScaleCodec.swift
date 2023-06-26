//
//  Collections.swift
//  
//
//  Created by Yehor Popovych on 10/10/20.
//

import Foundation

public protocol ContainerEncodable {
    associatedtype EElement
    
    func encode<E: Encoder>(in encoder: inout E, writer: @escaping (EElement, inout E) throws -> Void) throws
}

public protocol ContainerDecodable {
    associatedtype DElement
    
    init<D: Decoder>(from decoder: inout D, reader: @escaping (inout D) throws -> DElement) throws
}

extension ContainerEncodable where EElement: Encodable {
    @inlinable
    public func encode<E: Encoder>(in encoder: inout E) throws {
        try self.encode(in: &encoder) { val, enc in
            try enc.encode(val)
        }
    }
}

extension ContainerDecodable where DElement: Decodable {
    @inlinable
    public init<D: Decoder>(from decoder: inout D) throws {
        try self.init(from: &decoder) { try $0.decode() }
    }
}

public protocol DoubleContainerEncodable {
    associatedtype ELeft
    associatedtype ERight
    
    func encode<E: Encoder>(
        in encoder: inout E,
        lwriter: @escaping (ELeft, inout E) throws -> Void,
        rwriter: @escaping (ERight, inout E) throws -> Void
    ) throws
}

public protocol DoubleContainerDecodable {
    associatedtype DLeft
    associatedtype DRight
    
    init<D: Decoder>(
        from decoder: inout D,
        lreader: @escaping (inout D) throws -> DLeft,
        rreader: @escaping (inout D) throws -> DRight
    ) throws
}

extension DoubleContainerEncodable where ELeft: Encodable {
    @inlinable
    public func encode<E: Encoder>(in encoder: inout E, writer: @escaping (ERight, inout E) throws -> Void) throws {
        try encode(in: &encoder, lwriter: { val, enc in try enc.encode(val) }, rwriter: writer)
    }
}

extension DoubleContainerEncodable where ERight: Encodable {
    @inlinable
    public func encode<E: Encoder>(in encoder: inout E, writer: @escaping (ELeft, inout E) throws -> Void) throws {
        try encode(in: &encoder, lwriter: writer, rwriter: { val, enc in try enc.encode(val) })
    }
}

extension DoubleContainerDecodable where DLeft: Decodable {
    @inlinable
    public init<D: Decoder>(from decoder: inout D, reader: @escaping (inout D) throws -> DRight) throws {
        try self.init(from: &decoder, lreader: { try $0.decode() }, rreader: reader)
    }
}

extension DoubleContainerDecodable where DRight: Decodable {
    @inlinable
    public init<D: Decoder>(from decoder: inout D, reader: @escaping (inout D) throws -> DLeft) throws {
        try self.init(from: &decoder, lreader: reader, rreader: { try $0.decode() })
    }
}

