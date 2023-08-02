//
//  Tuples.swift
//  
//
//  Created by Yehor Popovych on 26/07/2023.
//

import Foundation
import Tuples

public extension ListTuple where DroppedLast: Decodable, Last: Decodable {
    @inlinable
    init<D: Decoder>(from decoder: inout D) throws {
        let prefix = try DroppedLast(from: &decoder)
        let last = try Last(from: &decoder)
        self.init(first: prefix, last: last)
    }
}

public extension ListTuple where DroppedLast: Encodable, Last: Encodable {
    @inlinable
    func encode<E: Encoder>(in encoder: inout E) throws {
        try dropLast.encode(in: &encoder)
        try last.encode(in: &encoder)
    }
}

public extension ListTuple where DroppedLast: SizeCalculable, Last: SizeCalculable {
    @inlinable
    static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try DroppedLast.calculateSize(in: &decoder) + Last.calculateSize(in: &decoder)
    }
}

public extension SomeTuple0 {
    @inlinable
    func encode<E: Encoder>(in encoder: inout E) throws {}
    @inlinable
    init<D: Decoder>(from decoder: inout D) throws { self.init() }
    @inlinable
    static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int { 0 }
}
