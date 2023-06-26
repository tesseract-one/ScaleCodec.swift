//
//  Tuple.swift
//  
//
//  Created by Yehor Popovych on 23/06/2023.
//

import Foundation

public protocol ATuple {
    associatedtype STuple
    
    init(_ t: STuple)
    
    var tuple: STuple { get }
    var count: Int { get }
    
    static var count: Int { get }
}

public extension ATuple {
    var count: Int { Self.count }
}

public protocol LinkedTuple: ATuple {
    associatedtype First
    associatedtype Last
    associatedtype DroppedFirst: ATuple
    associatedtype DroppedLast: ATuple
    
    init(first: DroppedLast, last: Last)
    init(first: First, last: DroppedFirst)
    
    var first: First { get }
    var last: Last { get }
    var dropLast: DroppedLast { get }
    var dropFirst: DroppedFirst { get }
}

public extension LinkedTuple {
    @inlinable
    init(first: DroppedLast.STuple, last: Last) {
        self.init(first: DroppedLast(first), last: last)
    }
    
    @inlinable
    init(first: First, last: DroppedFirst.STuple) {
        self.init(first: first, last: DroppedFirst(last))
    }
}


