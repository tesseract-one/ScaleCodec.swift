//
//  Encoder.swift
//
//
//  Created by Yehor Popovych on 9/30/20.
//

import Foundation

public protocol ScaleEncodable {
    func encode(in encoder: ScaleEncoder) throws;
}

public protocol ScaleEncoder {
    var path: [String] { get }
    var output: Data { get }
    
    @discardableResult
    func encode(_ value: ScaleEncodable) throws -> ScaleEncoder
    func write(_ bytes: [UInt8])
}

internal class SEncoder: ScaleEncoder {
    public private(set) var output: Data
    private var context: SContext
    
    public var path: [String] {
        return context.currentPath
    }
    
    init() {
        output = Data()
        context = SContext()
    }
    
    @discardableResult
    func encode(_ value: ScaleEncodable) throws -> ScaleEncoder {
        context.push(elem: type(of: value))
        defer { context.pop() }
        try value.encode(in: self)
        return self
    }
    
    func write(_ bytes: [UInt8]) {
        output.append(contentsOf: bytes)
    }
}
