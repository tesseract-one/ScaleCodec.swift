//
//  CompactTests.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import XCTest
import ScaleCodec

final class CompactTests: XCTestCase {
    
    func testUInt8() {
        runTests(uint8Values(UInt8.self))
    }
    
    func testUInt16() {
        runTests(uint16Values(UInt16.self))
    }
    
    func testUInt32() {
        runTests(uint32Values(UInt32.self))
    }
    
    func testUInt64() {
        runTests(uint64Values(UInt64.self))
    }
    
    func testUInt128() {
        runTests(uint128Values())
    }
    
    func testBigUInt() {
        let tests = uint128Values() + [
            (BigUInt.compactMax, Data(repeating: 0xff, count: 68).hex)
        ]
        runTests(tests)
        XCTAssertThrowsError(try SCALE.default.encode(BigUInt(2).power(537)))
    }
    
    
    func runTests<T: CompactCodable & Equatable>(_ tests: [(T, String)]) {
        let ctests = tests.map { (v, d) in
            return (SCompact(v), d)
        }
        RunEncDecTests(ctests)
    }
    
    func uint8Values<T: UnsignedInteger>(_ type: T.Type) -> [(T, String)] {
        return [
            (T(0), "00"), (T(63), "fc"), (T(64), "01 01"), (T(UInt8.max), "fd 03")
        ]
    }

    func uint16Values<T: UnsignedInteger>(_ type: T.Type) -> [(T, String)] {
        return uint8Values(type) + [
            (T(16383), "fd ff"), (T(16384), "02 00 01 00"), (T(UInt16.max), "fe ff 03 00")
        ]
    }

    func uint32Values<T: UnsignedInteger>(_ type: T.Type) -> [(T, String)] {
        return uint16Values(type) + [
            (T(1073741823), "fe ff ff ff"),
            (T(1073741824), "03 00 00 00 40"),
            (T(UInt32.max), "03 ff ff ff ff")
        ]
    }

    func uint64Values<T: UnsignedInteger>(_ type: T.Type) -> [(T, String)] {
        return uint32Values(type) + [
            (T(1 << 32), "07 00 00 00 00 01"),
            (T(1 << 40), "0b 00 00 00 00 00 01"),
            (T(1 << 48), "0f 00 00 00 00 00 00 01"),
            (T((1 << 56) - 1), "0f ff ff ff ff ff ff ff"),
            (T(1 << 56), "13 00 00 00 00 00 00 00 01"),
            (T(UInt64.max), "13 ff ff ff ff ff ff ff ff")
        ]
    }

    func uint128Values() -> [(BigUInt, String)] {
        return uint64Values(BigUInt.self) + [
            (BigUInt(2).power(64), "17 00 00 00 00 00 00 00 00 01"),
            (BigUInt(2).power(72) - 1, "17 ff ff ff ff ff ff ff ff ff"),
            (BigUInt(2).power(72), "1b 00 00 00 00 00 00 00 00 00 01"),
            (BigUInt(2).power(80) - 1, "1b ff ff ff ff ff ff ff ff ff ff"),
            (BigUInt(2).power(120), "33 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 01"),
            (BigUInt(2).power(128) - 1, "33 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff")
        ]
    }
}
