//
//  BigIntegers.swift
//  
//
//  Created by Yehor Popovych on 10/6/20.
//

import Foundation
#if !COCOAPODS
@_exported import DoubleWidth
#endif

// This part uses DoubleWidth from Apple Swift stdlib prototypes.
// Nested types will have performance drop, so avoid using them if not needed.
// Int128/UInt128 should be good. Int1024/UInt1024 is really slow.

public typealias Int128 = DoubleWidth<Int64>
public typealias Int256 = DoubleWidth<Int128>
public typealias Int512 = DoubleWidth<Int256>
public typealias Int1024 = DoubleWidth<Int512>

public typealias UInt128 = DoubleWidth<UInt64>
public typealias UInt256 = DoubleWidth<UInt128>
public typealias UInt512 = DoubleWidth<UInt256>
public typealias UInt1024 = DoubleWidth<UInt512>

extension DoubleWidth: CompactCodable where Base: UnsignedInteger {
    public typealias UI = Self
    
    public static var compactBitWidth: Int {
        Self.bitWidth >= SCOMPACT_BIT_WIDTH ? SCOMPACT_BIT_WIDTH : Self.bitWidth
    }
    
    public static var compactMax: UI {
        Self.bitWidth >= SCOMPACT_BIT_WIDTH ? UI(SCOMPACT_MAX_VALUE) : Self.max
    }
}

extension DoubleWidth: CompactConvertible where Base: UnsignedInteger {}

extension DoubleWidth: FixedDataCodable, DataConvertible, SizeCalculable {}

private let SCOMPACT_BIT_WIDTH: Int = 536
private let SCOMPACT_MAX_VALUE = (UInt1024(1) << SCOMPACT_BIT_WIDTH) - 1
