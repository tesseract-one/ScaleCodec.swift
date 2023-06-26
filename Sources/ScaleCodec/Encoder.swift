//
//  Encoder.swift
//
//
//  Created by Yehor Popovych on 9/30/20.
//

import Foundation

public protocol Encodable {
    func encode<E: Encoder>(in encoder: inout E) throws
}

public protocol Encoder {
    var path: [String] { get }
    var output: Data { get }
    
    mutating func encode<V: Encodable>(_ value: V) throws
    mutating func write(_ data: Data)
    mutating func write(_ byte: UInt8)
}

extension Encoder {
    public func errorContext(_ description: String) -> EncodingError.Context {
        EncodingError.Context(path: path, description: description)
    }
}

public struct DataEncoder: Encoder {
    public private(set) var output: Data
    private var context: SContext
    
    public var path: [String] {
        return context.currentPath
    }
    
    public init(reservedCapacity count: Int) {
        var data = Data()
        data.reserveCapacity(count)
        self.output = data
        self.context = SContext()
    }

    public mutating func encode<V: Encodable>(_ value: V) throws {
        context.push(elem: type(of: value))
        defer { context.pop() }
        try value.encode(in: &self)
    }
    
    public mutating func write(_ data: Data) {
        output.append(data)
    }
    
    public mutating func write(_ byte: UInt8) {
        output.append(byte)
    }
}
