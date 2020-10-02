//
//  Array.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import XCTest
import ScaleCodec

final class ArrayTests: XCTestCase {
    
    func testStringArray() {
        let values = ["Hamlet", "Война и мир", "三国演义", "أَلْف لَيْلَة وَلَيْلَة‎"];
        let encoded = """
        10 18 48 61 6d 6c 65 74 50 d0 92 d0 be d0 b9 d0 bd d0 b0 20 d0 \
        b8 20 d0 bc d0 b8 d1 80 30 e4 b8 89 e5 9b bd e6 bc 94 e4 b9 89 bc d8 a3 d9 8e d9 84 d9 92 \
        d9 81 20 d9 84 d9 8e d9 8a d9 92 d9 84 d9 8e d8 a9 20 d9 88 d9 8e d9 84 d9 8e d9 8a d9 92 \
        d9 84 d9 8e d8 a9 e2 80 8e
        """
        let data = XCTAssertNoThrowS(try SCALE.default.encode(values))
        XCTAssertEqual(data?.hex, encoded)
        let decoded = XCTAssertNoThrowS(try SCALE.default.decode(Array<String>.self, from: encoded.hexData!))
        XCTAssertEqual(decoded, values)
    }
}
