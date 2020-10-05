//
//  Array.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import XCTest
import ScaleCodec

final class ArrayTests: XCTestCase {
    
    func testString() {
        let values = ["Hamlet", "Война и мир", "三国演义", "أَلْف لَيْلَة وَلَيْلَة‎"];
        let encoded = """
        10 18 48 61 6d 6c 65 74 50 d0 92 d0 be d0 b9 d0 bd d0 b0 20 d0 \
        b8 20 d0 bc d0 b8 d1 80 30 e4 b8 89 e5 9b bd e6 bc 94 e4 b9 89 bc d8 a3 d9 8e d9 84 d9 92 \
        d9 81 20 d9 84 d9 8e d9 8a d9 92 d9 84 d9 8e d8 a9 20 d9 88 d9 8e d9 84 d9 8e d9 8a d9 92 \
        d9 84 d9 8e d8 a9 e2 80 8e
        """
        RunEncDecTests([(values, encoded)])
    }
    
    func testUInt8() {
        let value: [UInt8] = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34]
        let encoded = "28 00 01 01 02 03 05 08 0d 15 22"
        RunEncDecTests([(value, encoded)])
    }
    
    func testInt16() {
        let value: [Int16] = [0, 1, -1, 2, -2, 3, -3];
        let encoded = "1c 00 00 01 00 ff ff 02 00 fe ff 03 00 fd ff"
        RunEncDecTests([(value, encoded)])
    }
    
    func testOptionalInt8() {
        let value: [Int8?] = [1, -1, nil]
        let encoded = "0c 01 01 01 ff 00"
        RunEncDecTests([(value, encoded)])
    }
    
    func testOptionalBool() {
        let value: [Bool?] = [false, true, nil];
        let encoded = "0c 02 01 00"
        RunEncDecTests([(value, encoded)])
    }
    
    func testFixedArray() {
        let value: [UInt16] = [1, 2, 3, 0, UInt16.max]
        let encoded = "01 00 02 00 03 00 00 00 ff ff"
        do {
            let data = try SCALE.default.encode(value, fixed: 5)
            XCTAssertEqual(data.hex, encoded)
            let decoded = try SCALE.default.decode(Array<UInt16>.self, .fixed(5), from: data)
            XCTAssertEqual(decoded, value)
        } catch { XCTFail("\(error)") }
        XCTAssertThrowsError(try SCALE.default.encode(value, fixed: 3))
        XCTAssertThrowsError(try SCALE.default.decode(Array<UInt16>.self, .fixed(6), from: encoded.hexData!))
    }
}
