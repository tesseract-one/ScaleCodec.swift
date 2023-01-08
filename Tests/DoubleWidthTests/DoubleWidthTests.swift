//
//  DoubleWidthTests.swift
//  
//
//  Created by Yehor Popovych on 1/8/23.
//

import XCTest
#if os(Linux) || os(tvOS)
import CwlPosixPreconditionTesting
#else
import CwlPreconditionTesting
#endif
@testable import ScaleCodec

final class DoubleWidthTests: XCTestCase {
    func testArithmetic_unsigned() {
        let x: DoubleWidth<UInt8> = 1000
        let y: DoubleWidth<UInt8> = 1111
        XCTAssertEqual(x + 1, 1001)
        XCTAssertEqual(x + x, 2000)
        XCTAssertEqual(x - (1 as DoubleWidth<UInt8>), 999)
        XCTAssertEqual(x - x, 0)
        XCTAssertEqual(y - x, 111)
        
        XCTAssertEqual(x * 7, 7000)
        XCTAssertEqual(y * 7, 7777)
        
        XCTAssertEqual(x / 3, 333)
        XCTAssertEqual(x / x, 1)
        XCTAssertEqual(x / y, 0)
        XCTAssertEqual(y / x, 1)
        
        XCTAssertEqual(x % 3, 1)
        XCTAssertEqual(x % y, x)
    }
    
    func testArithmetic_signed() {
        let x: DoubleWidth<Int8> = 1000
        let y: DoubleWidth<Int8> = -1111
        XCTAssertEqual(x + 1, 1001)
        XCTAssertEqual(x + x, 2000)
        XCTAssertEqual(x - (1 as DoubleWidth<Int8>), 999)
        XCTAssertEqual(x - x, 0)
        XCTAssertEqual(0 - x, -1000)
        XCTAssertEqual(x + y, -111)
        XCTAssertEqual(x - y, 2111)
        
        XCTAssertEqual(x * 7, 7000)
        XCTAssertEqual(y * 7, -7777)
        XCTAssertEqual(x * -7, -7000)
        XCTAssertEqual(y * -7, 7777)
        
        XCTAssertEqual(x / 3, 333)
        XCTAssertEqual(x / -3, -333)
        XCTAssertEqual(x / x, 1)
        XCTAssertEqual(x / y, 0)
        XCTAssertEqual(y / x, -1)
        XCTAssertEqual(y / y, 1)
        
        XCTAssertEqual(x % 3, 1)
        XCTAssertEqual(x % -3, 1)
        XCTAssertEqual(y % 3, -1)
        XCTAssertEqual(y % -3, -1)
        
        XCTAssertEqual(-y, 1111)
        XCTAssertEqual(-x, -1000)
    }
    
    func testNested() {
        do {
            let x = UInt1024.max
            let (y, o) = x.addingReportingOverflow(1)
            XCTAssertEqual(y, 0)
            XCTAssertTrue(y == (0 as Int))
            XCTAssertTrue(o)
        }
        
        do {
            let x = Int1024.max
            let (y, o) = x.addingReportingOverflow(1)
            XCTAssertEqual(y, Int1024.min)
            XCTAssertTrue(y < 0)
            XCTAssertTrue(y < (0 as Int))
            XCTAssertTrue(y < (0 as UInt))
            XCTAssertTrue(o)
        }
        
        XCTAssertFalse(UInt1024.isSigned)
        XCTAssertEqual(UInt1024.bitWidth, 1024)
        XCTAssertTrue(Int1024.isSigned)
        XCTAssertEqual(Int1024.bitWidth, 1024)
        
        XCTAssertEqual(
            Array(UInt1024.max.words), Array(repeatElement(UInt.max, count: 1024 / UInt.bitWidth)))
    }
    
    func testinits() {
        typealias DWU16 = DoubleWidth<UInt8>
        
        XCTAssertTrue(DWU16(UInt16.max) == UInt16.max)
        XCTAssertNil(DWU16(exactly: UInt32.max))
        XCTAssertEqual(DWU16(truncatingIfNeeded: UInt64.max), DWU16.max)
        
        let e = catchBadInstruction {
            _ = DWU16(UInt32.max)
        }
        XCTAssertNotNil(e)
    }
    
    func testMagnitude() {
        typealias DWU16 = DoubleWidth<UInt8>
        typealias DWI16 = DoubleWidth<Int8>
        
        XCTAssertTrue(DWU16.min.magnitude == UInt16.min.magnitude)
        XCTAssertTrue((42 as DWU16).magnitude == (42 as UInt16).magnitude)
        XCTAssertTrue(DWU16.max.magnitude == UInt16.max.magnitude)
        
        XCTAssertTrue(DWI16.min.magnitude == Int16.min.magnitude)
        XCTAssertTrue((-42 as DWI16).magnitude == (-42 as Int16).magnitude)
        XCTAssertTrue(DWI16().magnitude == Int16(0).magnitude) // See https://github.com/apple/swift/issues/49152.
        XCTAssertTrue((42 as DWI16).magnitude == (42 as Int16).magnitude)
        XCTAssertTrue(DWI16.max.magnitude == Int16.max.magnitude)
    }
    
    func testTwoWords() {
        typealias DW = DoubleWidth<Int>
        
        XCTAssertEqual(-1 as DW, DW(truncatingIfNeeded: -1 as Int8))
        
        XCTAssertNil(Int(exactly: DW(Int.min) - 1))
        XCTAssertNil(Int(exactly: DW(Int.max) + 1))
        
        XCTAssertTrue(DW(Int.min) - 1 < Int.min)
        XCTAssertTrue(DW(Int.max) + 1 > Int.max)
    }
    
    func testBitshifts() {
        typealias DWU64 = DoubleWidth<DoubleWidth<DoubleWidth<UInt8>>>
        typealias DWI64 = DoubleWidth<DoubleWidth<DoubleWidth<Int8>>>
        
        func f<T: FixedWidthInteger, U: FixedWidthInteger>(_ x: T, type: U.Type) {
            let y = U(x)
            XCTAssertEqual(T.bitWidth, U.bitWidth)
            for i in -(T.bitWidth + 1)...(T.bitWidth + 1) {
                XCTAssertTrue(x << i == y << i)
                XCTAssertTrue(x >> i == y >> i)
                
                XCTAssertTrue(x &<< i == y &<< i)
                XCTAssertTrue(x &>> i == y &>> i)
            }
        }
        
        f(1 as UInt64, type: DWU64.self)
        f(~(~0 as UInt64 >> 1), type: DWU64.self)
        f(UInt64.max, type: DWU64.self)
        // 0b01010101_10100101_11110000_10100101_11110000_10100101_11110000_10100101
        f(17340530535757639845 as UInt64, type: DWU64.self)
        
        f(1 as Int64, type: DWI64.self)
        f(Int64.min, type: DWI64.self)
        f(Int64.max, type: DWI64.self)
        // 0b01010101_10100101_11110000_10100101_11110000_10100101_11110000_10100101
        f(6171603459878809765 as Int64, type: DWI64.self)
    }
    
    func testRemainder_DividingBy0() {
        func f(_ x: Int1024, _ y: Int1024) -> Int1024 {
            return x % y
        }
        let e = catchBadInstruction {
            _ = f(42, 0)
        }
        XCTAssertNotNil(e)
    }
    
    func testRemainderReportingOverflow_DividingByMinusOne() {
        func f(_ x: Int256, _ y: Int256) -> Int256 {
            return x.remainderReportingOverflow(dividingBy: y).partialValue
        }
        XCTAssertEqual(f(.max, -1), 0)
        XCTAssertEqual(f(.min, -1), 0)
    }
    
    func testDivision_By0() {
        func f(_ x: Int1024, _ y: Int1024) -> Int1024 {
            return x / y
        }
        let e = catchBadInstruction {
            _ = f(42, 0)
        }
        XCTAssertNotNil(e)
    }
    
    func testDivideMinByMinusOne() {
        func f(_ x: Int1024) -> Int1024 {
            return x / -1
        }
        let e = catchBadInstruction {
            _ = f(Int1024.min)
        }
        XCTAssertNotNil(e)
    }
    
    func testisMultiple() {
        func isMultipleTest<T: FixedWidthInteger>(type: T.Type) {
            XCTAssertTrue(T.min.isMultiple(of: 2))
            XCTAssertFalse(T.max.isMultiple(of: 10))
            // Test that these do not crash.
            XCTAssertTrue((0 as T).isMultiple(of: 0))
            XCTAssertFalse((1 as T).isMultiple(of: 0))
            XCTAssertTrue(T.min.isMultiple(of: 0 &- 1))
        }
        isMultipleTest(type: Int128.self)
        isMultipleTest(type: UInt128.self)
    }
    
    func testMultiplyMinByMinusOne() {
        func f(_ x: Int1024) -> Int1024 {
            return x * -1
        }
        let e = catchBadInstruction {
            _ = f(Int1024.min)
        }
        XCTAssertNotNil(e)
    }
    
    typealias DWI16 = DoubleWidth<Int8>
    typealias DWU16 = DoubleWidth<UInt8>
    
    func testConversions() {
        XCTAssertTrue(DWI16(1 << 15 - 1) == Int(1 << 15 - 1))
        XCTAssertTrue(DWI16(-1 << 15) == Int(-1 << 15))
        XCTAssertTrue(DWU16(1 << 16 - 1) == Int(1 << 16 - 1))
        XCTAssertTrue(DWU16(0) == Int(0))
        
        XCTAssertTrue(DWI16(Double(1 << 15 - 1)) == Int(1 << 15 - 1))
        XCTAssertTrue(DWI16(Double(-1 << 15)) == Int(-1 << 15))
        XCTAssertTrue(DWU16(Double(1 << 16 - 1)) == Int(1 << 16 - 1))
        XCTAssertTrue(DWU16(Double(0)) == Int(0))
        
        XCTAssertTrue(DWI16(Double(1 << 15 - 1) + 0.9) == Int(1 << 15 - 1))
        XCTAssertTrue(DWI16(Double(-1 << 15) - 0.9) == Int(-1 << 15))
        XCTAssertTrue(DWU16(Double(1 << 16 - 1) + 0.9) == Int(1 << 16 - 1))
        XCTAssertTrue(DWU16(Double(0) - 0.9) == Int(0))
        
        XCTAssertEqual(DWI16(0.00001), 0)
        XCTAssertEqual(DWU16(0.00001), 0)
    }
    
    func testExact_Conversions() {
        XCTAssertEqual(DWI16(Double(1 << 15 - 1)), DWI16(exactly: Double(1 << 15 - 1))!)
        XCTAssertEqual(DWI16(Double(-1 << 15)), DWI16(exactly: Double(-1 << 15))!)
        XCTAssertEqual(DWU16(Double(1 << 16 - 1)), DWU16(exactly: Double(1 << 16 - 1))!)
        XCTAssertEqual(DWU16(Double(0)), DWU16(exactly: Double(0))!)
        
        XCTAssertNil(DWI16(exactly: Double(1 << 15 - 1) + 0.9))
        XCTAssertNil(DWI16(exactly: Double(-1 << 15) - 0.9))
        XCTAssertNil(DWU16(exactly: Double(1 << 16 - 1) + 0.9))
        XCTAssertNil(DWU16(exactly: Double(0) - 0.9))
        
        XCTAssertNil(DWI16(exactly: Double(1 << 15)))
        XCTAssertNil(DWI16(exactly: Double(-1 << 15) - 1))
        XCTAssertNil(DWU16(exactly: Double(1 << 16)))
        XCTAssertNil(DWU16(exactly: Double(-1)))
        
        XCTAssertNil(DWI16(exactly: 0.00001))
        XCTAssertNil(DWU16(exactly: 0.00001))
        
        XCTAssertNil(DWU16(exactly: Double.nan))
        XCTAssertNil(DWU16(exactly: Float.nan))
        XCTAssertNil(DWU16(exactly: Double.infinity))
        XCTAssertNil(DWU16(exactly: Float.infinity))
    }
    
    func testConversions_SignedMaxP1() {
        let e = catchBadInstruction {
            _ = DWI16(1 << 15)
        }
        XCTAssertNotNil(e)
    }
    
    func testConversions_SignedMinM1() {
        let e = catchBadInstruction {
            _ = DWI16(-1 << 15 - 1)
        }
        XCTAssertNotNil(e)
    }
    
    func testConversions_UnsignedMaxP1() {
        let e = catchBadInstruction {
            _ = DWU16(1 << 16)
        }
        XCTAssertNotNil(e)
    }
    
    func testConversions_UnsignedM1() {
        let e = catchBadInstruction {
            _ = DWU16(-1)
        }
        XCTAssertNotNil(e)
    }
    
    func testConversions_String() {
        XCTAssertEqual(String(Int256.max, radix: 16),
                       "7fffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff")
        XCTAssertEqual(String(Int256.min, radix: 16),
                       "-8000000000000000000000000000000000000000000000000000000000000000")
        
        XCTAssertEqual(String(Int256.max, radix: 2), """
        1111111111111111111111111111111111111111111111111111111111111111\
        1111111111111111111111111111111111111111111111111111111111111111\
        1111111111111111111111111111111111111111111111111111111111111111\
        111111111111111111111111111111111111111111111111111111111111111
        """)
        XCTAssertEqual(String(Int256.min, radix: 2), """
        -100000000000000000000000000000000000000000000000000000000000000\
        0000000000000000000000000000000000000000000000000000000000000000\
        0000000000000000000000000000000000000000000000000000000000000000\
        00000000000000000000000000000000000000000000000000000000000000000
        """)
        
        XCTAssertEqual(String(Int128.max, radix: 10),
                       "170141183460469231731687303715884105727")
        XCTAssertEqual(String(Int128.min, radix: 10),
                       "-170141183460469231731687303715884105728")
    }
    
    func testWords() {
        XCTAssertEqual(Array((0 as DoubleWidth<Int8>).words), [0])
        XCTAssertEqual(Array((1 as DoubleWidth<Int8>).words), [1])
        XCTAssertEqual(Array((-1 as DoubleWidth<Int8>).words), [UInt.max])
        XCTAssertEqual(Array((256 as DoubleWidth<Int8>).words), [256])
        XCTAssertEqual(Array((-256 as DoubleWidth<Int8>).words), [UInt.max - 255])
        XCTAssertEqual(Array(DoubleWidth<Int8>.max.words), [32767])
        XCTAssertEqual(Array(DoubleWidth<Int8>.min.words), [UInt.max - 32767])
        
        XCTAssertEqual(Array((0 as Int1024).words),
                       Array(repeatElement(0 as UInt, count: 1024 / UInt.bitWidth)))
        XCTAssertEqual(Array((-1 as Int1024).words),
                       Array(repeatElement(UInt.max, count: 1024 / UInt.bitWidth)))
        XCTAssertEqual(Array((1 as Int1024).words),
                       [1] + Array(repeating: 0, count: 1024 / UInt.bitWidth - 1))
    }
    
    func testConditional_Conformance() {
        checkSignedIntegerConformance(0 as Int128)
        checkSignedIntegerConformance(0 as Int1024)
        
        checkUnsignedIntegerConformance(0 as UInt128)
        checkUnsignedIntegerConformance(0 as UInt1024)
    }
    
    func checkSignedIntegerConformance<T: SignedInteger>(_ x: T) {}
    func checkUnsignedIntegerConformance<T: UnsignedInteger>(_ x: T) {}
}
