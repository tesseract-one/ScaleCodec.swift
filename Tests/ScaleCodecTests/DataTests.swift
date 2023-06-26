//
//  DataTests.swift
//  
//
//  Created by Yehor Popovych on 10/5/20.
//

import XCTest
import ScaleCodec

final class DataTests: XCTestCase {
    
    func testVariableData() {
        let tests: [(Data, String)] = [
            (Data([0, 1, 1, 2, 3, 5, 8, 13, 21, 34]), "28 00 01 01 02 03 05 08 0d 15 22"),
            (Data([0, 1, 255, 2, 254, 3, 253]), "1c 00 01 ff 02 fe 03 fd")
        ]
        RunEncDecTests(tests)
    }
    
    func testFixedData() {
        let data = Data([0, 1, 1, 2, 3, 5, 8, 13, 21, 34])
        let encoded = "00 01 01 02 03 05 08 0d 15 22"
        do {
            let enc = try ScaleCodec.encode(data, .fixed(10))
            XCTAssertEqual(encoded, enc.hex)
            let dec = try ScaleCodec.decode(Data.self, .fixed(10), from: encoded.hexData!)
            XCTAssertEqual(dec, data)
        } catch { XCTFail("\(error)") }
        XCTAssertThrowsError(try ScaleCodec.encode(data, .fixed(12)))
        XCTAssertThrowsError(try ScaleCodec.decode(Data.self, .fixed(11), from: encoded.hexData!))
    }
    
}
