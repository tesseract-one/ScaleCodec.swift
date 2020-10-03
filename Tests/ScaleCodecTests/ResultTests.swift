//
//  ResultTests.swift
//  
//
//  Created by Yehor Popovych on 10/3/20.
//

import XCTest
import ScaleCodec

final class ResultTests: XCTestCase {
    func testSimple() {
        let tests: [(Result<UInt8, TError>, String)] = [
            (.success(10), "00 0a"),
            (.success(.max), "00 ff"),
            (.failure(.err), "01 00"),
        ]
        RunEncDecTests(tests)
    }
    
    func testNestedOptional() {
        let tests: [(Result<UInt8?, TError>, String)] = [
            (.success(10), "00 01 0a"),
            (.success(.max), "00 01 ff"),
            (.success(nil), "00 00"),
            (.failure(.err), "01 00"),
        ]
        RunEncDecTests(tests)
    }
    
    func testBadData() {
        XCTAssertThrowsError(try SCALE.default.decode(Result<UInt8, TError>.self, from: "ff 00".hexData!))
    }
}

private enum TError: CaseIterable, Error, ScaleCodable {
    case err
}
