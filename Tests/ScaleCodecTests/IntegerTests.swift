//
//  IntegerTests.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import XCTest
import ScaleCodec

final class IntegerTests: XCTestCase {
    
    func testBool() {
        let tests: [(Bool, String)] = [
            (false, "00"),
            (true, "01")
        ]
        RunEncDecTests(tests)
        XCTAssertThrowsError(try SCALE.default.decode(Bool.self, from: Data([0x02])))
    }
    
    func testInt8() {
        let tests = intValues(
            max: Int8.max,
            min: Int8.min,
            bytes: Int8.bitWidth / 8
        )
        RunEncDecTests(tests)
    }
    
    func testUInt8() {
        let tests = uintValues(
            max: UInt8.max,
            bytes: UInt8.bitWidth / 8
        )
        RunEncDecTests(tests)
    }
    
    func testInt16() {
        let tests = intValues(
            max: Int16.max,
            min: Int16.min,
            bytes: Int16.bitWidth / 8
        )
        RunEncDecTests(tests)
    }
    
    func testUInt16() {
        let tests = uintValues(
            max: UInt16.max,
            bytes: UInt16.bitWidth / 8
        )
        RunEncDecTests(tests)
    }
    
    func testInt32() {
        let tests = intValues(
            max: Int32.max,
            min: Int32.min,
            bytes: Int32.bitWidth / 8
        )
        RunEncDecTests(tests)
    }
    
    func testUInt32() {
        let tests = uintValues(
            max: UInt32.max,
            bytes: UInt32.bitWidth / 8
        )
        RunEncDecTests(tests)
    }
    
    func testInt64() {
        let tests = intValues(
            max: Int64.max,
            min: Int64.min,
            bytes: Int64.bitWidth / 8
        )
        RunEncDecTests(tests)
    }
    
    func testUInt64() {
        let tests = uintValues(
            max: UInt64.max,
            bytes: UInt64.bitWidth / 8
        )
        RunEncDecTests(tests)
    }
    
    func testInt128() {
        let tests_bi = intValues(
            max: SInt128.max,
            min: SInt128.min,
            bytes: 16
        )
        let tests = tests_bi.map { (SInt128($0.0), $0.1) }
        RunEncDecTests(tests)
        XCTAssertThrowsError(try SCALE.default.encode(b128: SInt128.max + 1))
        XCTAssertThrowsError(try SCALE.default.encode(b128: SInt128.min - 1))
    }
    
    func testUInt128() {
        let tests_bi = uintValues(
            max: SUInt128.max,
            bytes: 16
        )
        let tests = tests_bi.map { (SUInt128($0.0), $0.1) }
        RunEncDecTests(tests)
        XCTAssertThrowsError(try SCALE.default.encode(b128: SUInt128.max + 1))
    }
    
    func testInt256() {
        let tests_bi = intValues(
            max: SInt256.max,
            min: SInt256.min,
            bytes: 32
        )
        let tests = tests_bi.map { (SInt256($0.0), $0.1) }
        XCTAssertThrowsError(try SCALE.default.encode(b256: SInt256.max + 1))
        XCTAssertThrowsError(try SCALE.default.encode(b256: SInt256.min - 1))
        RunEncDecTests(tests)
    }
    
    func testUInt256() {
        let tests_bi = uintValues(
            max: SUInt256.max,
            bytes: 32
        )
        let tests = tests_bi.map { (SUInt256($0.0), $0.1) }
        RunEncDecTests(tests)
        XCTAssertThrowsError(try SCALE.default.encode(b256: SUInt256.max + 1))
    }
    
    func testInt512() {
        let tests_bi = intValues(
            max: SInt512.max,
            min: SInt512.min,
            bytes: 64
        )
        let tests = tests_bi.map { (SInt512($0.0), $0.1) }
        RunEncDecTests(tests)
        XCTAssertThrowsError(try SCALE.default.encode(b512: SInt512.max + 1))
        XCTAssertThrowsError(try SCALE.default.encode(b512: SInt512.min - 1))
    }
    
    func testUInt512() {
        let tests_bi = uintValues(
            max: SUInt512.max,
            bytes: 64
        )
        let tests = tests_bi.map { (SUInt512($0.0), $0.1) }
        RunEncDecTests(tests)
        XCTAssertThrowsError(try SCALE.default.encode(b512: SUInt512.max + 1))
    }
    
    func uintValues<T: UnsignedInteger>(max: T, bytes: Int) -> [(T, String)] {
        let z = Data(repeating: 0x00, count: bytes)
        let m = Data(repeating: 0xff, count: bytes)
        let h = Data(repeating: 0x00, count: bytes - 1) + Data([0x80])
        let p1 = Data([0x01]) + Data(repeating: 0x00, count: bytes - 1)
        return [ (T(0), z.hex), (T(1), p1.hex), (max/2+1, h.hex), (max, m.hex) ]
    }
        
    func intValues<T: SignedInteger>(max: T, min: T, bytes: Int) -> [(T, String)] {
        let mn = Data(repeating: 0x00, count: bytes - 1) + Data([0x80])
        let mx = Data(repeating: 0xff, count: bytes - 1) + Data([0x7f])
        let z = Data(repeating: 0x00, count: bytes)
        let m1 = Data(repeating: 0xff, count: bytes)
        let p1 = Data([0x01]) + Data(repeating: 0x00, count: bytes - 1)
        return [(min, mn.hex), (T(-1), m1.hex), (T(0), z.hex), (T(1), p1.hex), (max, mx.hex)]
    }
}
