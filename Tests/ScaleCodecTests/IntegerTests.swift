//
//  IntegerTests.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import XCTest
import ScaleCodec

final class IntegerTests: XCTestCase {
    func testInt128() {
        let int128_min_d = Data(repeating: 0x00, count: 15) + Data([0x80])
        let int128_max_d = Data(repeating: 0xff, count: 15) + Data([0x7f])
        let int128_0_d = Data(repeating: 0x00, count: 16)
        let int128_m1_d = Data(repeating: 0xff, count: 16)
        let int128_m2_d = Data([0xfe]) + Data(repeating: 0xff, count: 15)
        
        let int128_min = BigInt(sign: .minus, magnitude: BigUInt(2).power(127))
        let int128_max = BigInt(2).power(127) - 1
        let int128_0 = BigInt(0)
        let int128_m1 = BigInt(-1)
        let int128_m2 = BigInt(-2)
        
        do {
            let max_enc = try SCALE.default.encode(int128_max)
            let min_enc = try SCALE.default.encode(int128_min)
            let enc_0 = try SCALE.default.encode(int128_0)
            let enc_m1 = try SCALE.default.encode(int128_m1)
            let enc_m2 = try SCALE.default.encode(int128_m2)
            XCTAssertEqual(max_enc, int128_max_d)
            XCTAssertEqual(min_enc, int128_min_d)
            XCTAssertEqual(enc_0, int128_0_d)
            XCTAssertEqual(enc_m1, int128_m1_d)
            XCTAssertEqual(enc_m2, int128_m2_d)
            let min = try SCALE.default.decode(BigInt.self, from: int128_min_d)
            let max = try SCALE.default.decode(BigInt.self, from: int128_max_d)
            let _0 = try SCALE.default.decode(BigInt.self, from: int128_0_d)
            let m1 = try SCALE.default.decode(BigInt.self, from: int128_m1_d)
            let m2 = try SCALE.default.decode(BigInt.self, from: int128_m2_d)
            XCTAssertEqual(min, int128_min)
            XCTAssertEqual(max, int128_max)
            XCTAssertEqual(_0, int128_0)
            XCTAssertEqual(m1, int128_m1)
            XCTAssertEqual(m2, int128_m2)
        } catch {
            XCTFail("\(error)")
        }
    }
}
