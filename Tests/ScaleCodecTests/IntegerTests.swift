//
//  IntegerTests.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import XCTest
import ScaleCodec

final class IntegerTests: XCTestCase {
    
    func testInt8() {
        let tests = intValues(
            max: Int8.max,
            min: Int8.min,
            bytes: Int8.bitWidth / 8
        )
        runTests(tests)
    }
    
    func testUInt8() {
        let tests = uintValues(
            max: UInt8.max,
            bytes: UInt8.bitWidth / 8
        )
        runTests(tests)
    }
    
    func testInt16() {
        let tests = intValues(
            max: Int16.max,
            min: Int16.min,
            bytes: Int16.bitWidth / 8
        )
        runTests(tests)
    }
    
    func testUInt16() {
        let tests = uintValues(
            max: UInt16.max,
            bytes: UInt16.bitWidth / 8
        )
        runTests(tests)
    }
    
    func testInt32() {
        let tests = intValues(
            max: Int32.max,
            min: Int32.min,
            bytes: Int32.bitWidth / 8
        )
        runTests(tests)
    }
    
    func testUInt32() {
        let tests = uintValues(
            max: UInt32.max,
            bytes: UInt32.bitWidth / 8
        )
        runTests(tests)
    }
    
    func testInt64() {
        let tests = intValues(
            max: Int64.max,
            min: Int64.min,
            bytes: Int64.bitWidth / 8
        )
        runTests(tests)
    }
    
    func testUInt64() {
        let tests = uintValues(
            max: UInt64.max,
            bytes: UInt64.bitWidth / 8
        )
        runTests(tests)
    }
    
    func testInt128() {
        let tests = intValues(
            max: BigInt(2).power(127) - 1,
            min: BigInt(sign: .minus, magnitude: BigUInt(2).power(127)),
            bytes: 16
        )
        runTests(tests)
    }
    
    func testUInt128() {
        let tests = uintValues(
            max: BigUInt(2).power(128) - 1,
            bytes: 16
        )
        runTests(tests)
    }
    
    func testBigIntError() {
        XCTAssertThrowsError(try SCALE.default.encode(BigInt(2).power(127)))
        XCTAssertThrowsError(try SCALE.default.encode(BigInt(-2).power(127)-1))
    }
    
    func testBigUIntError() {
        XCTAssertThrowsError(try SCALE.default.encode(BigUInt(2).power(128)))
    }
    
    func runTests<T: BinaryInteger & ScaleCodable>(_ tests: [(T, String)]) {
        let codec = SCALE()
        
        for (v, d) in tests {
            do {
                let data = try codec.encode(v)
                let decoded = try codec.decode(T.self, from: d.hexData!)
                XCTAssertEqual(data.hex, d)
                XCTAssertEqual(decoded, v)
            } catch {
                XCTFail("\(error)")
            }
        }
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
