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
    func write(_ data: Data)
    
    // Make a copy of encoder preserving `path`.
    // If full = True data will be copied too
    func fork(full: Bool) -> ScaleEncoder
}

internal class SEncoder: ScaleEncoder {
    public private(set) var output: Data
    private var context: SContext
    
    public var path: [String] {
        return context.currentPath
    }
    
    convenience init() {
        self.init(output: Data(), context: SContext())
    }
    
    init(output: Data, context: SContext) {
        self.output = output
        self.context = context
    }
    
    @discardableResult
    func encode(_ value: ScaleEncodable) throws -> ScaleEncoder {
        context.push(elem: type(of: value))
        defer { context.pop() }
        try value.encode(in: self)
        return self
    }
    
    func write(_ data: Data) {
        output.append(data)
    }
    
    func fork(full: Bool) -> ScaleEncoder {
        let out = full ? Data(output) : Data()
        return SEncoder(output: out, context: SContext(Array(context.currentPath)))
    }
}
