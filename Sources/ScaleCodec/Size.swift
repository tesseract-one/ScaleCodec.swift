//
//  Size.swift
//  
//
//  Created by Yehor Popovych on 23/06/2023.
//

import Foundation

public protocol SizeCalculable {
    static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int
}

public protocol ContainerSizeCalculable {
    associatedtype SElement
    
    static func calculateSize<D: SkippableDecoder>(
        in decoder: inout D,
        esize: @escaping (inout D) throws -> Int
    ) throws -> Int
}

public extension ContainerSizeCalculable where SElement: SizeCalculable {
    static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try calculateSize(in: &decoder) { try SElement.calculateSize(in: &$0) }
    }
}

public protocol DoubleContainerSizeCalculable {
    associatedtype SLeft
    associatedtype SRight
    
    static func calculateSize<D: SkippableDecoder>(
        in decoder: inout D,
        lsize: @escaping (inout D) throws -> Int,
        rsize: @escaping (inout D) throws -> Int
    ) throws -> Int
}

public extension DoubleContainerSizeCalculable where SLeft: SizeCalculable {
    static func calculateSize<D: SkippableDecoder>(
        in decoder: inout D,
        esize: @escaping (inout D) throws -> Int
    ) throws -> Int {
        try calculateSize(in: &decoder,
                          lsize: { try SLeft.calculateSize(in: &$0) },
                          rsize: esize)
    }
}

public extension DoubleContainerSizeCalculable where SRight: SizeCalculable {
    static func calculateSize<D: SkippableDecoder>(
        in decoder: inout D,
        esize: @escaping (inout D) throws -> Int
    ) throws -> Int {
        try calculateSize(in: &decoder,
                          lsize: esize,
                          rsize: { try SRight.calculateSize(in: &$0) })
    }
}
