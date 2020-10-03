//
//  OptionalTests.swift
//  
//
//  Created by Yehor Popovych on 10/3/20.
//

import XCTest
import ScaleCodec

final class OptionalTests: XCTestCase {
    func testBool() {
        let tests: [(Bool?, String)] = [
            (nil, "00"),
            (false, "01"),
            (true, "02")
        ]
        RunEncDecTests(tests)
        XCTAssertThrowsError(try SCALE.default.decode(Optional<Bool>.self, from: Data([0x03])))
    }
    
    func testInt() {
        do {
            let tests: [(Int32?, String)] = [
                (nil, "00"),
                (Int32.min, "01 \(try SCALE.default.encode(Int32.min).hex)"),
                (0, "01 \(try SCALE.default.encode(Int32(0)).hex)"),
                (Int32.max, "01 \(try SCALE.default.encode(Int32.max).hex)")
            ]
            RunEncDecTests(tests)
        } catch { XCTFail("\(error)") }
    }
    
    func testString() {
        do {
            let tests: [(String?, String)] = [
                (nil, "00"),
                ("Hello", "01 \(try SCALE.default.encode("Hello").hex)"),
                ("World!", "01 \(try SCALE.default.encode("World!").hex)"),
                ("", "01 \(try SCALE.default.encode("").hex)")
            ]
            RunEncDecTests(tests)
        } catch { XCTFail("\(error)") }
    }
    
    func testArray() {
        do {
            let tests1: [([TEnum]?, String)] = [
                (nil, "00"),
                ([TEnum.c1, TEnum.c2], "01 \(try SCALE.default.encode([TEnum.c1, TEnum.c2]).hex)"),
            ]
            let tests2: [([UInt32]?, String)] = [
                (nil, "00"),
                ([UInt32(100), UInt32(256), UInt32.min, UInt32.max],
                 "01 \(try SCALE.default.encode([UInt32(100), UInt32(256), UInt32.min, UInt32.max]).hex)"),
            ]
            let tests3: [([String]?, String)] = [
                (nil, "00"),
                (["Hello", "World!", ""], "01 \(try SCALE.default.encode(["Hello", "World!", ""]).hex)"),
            ]
            RunEncDecTests(tests1)
            RunEncDecTests(tests2)
            RunEncDecTests(tests3)
        } catch { XCTFail("\(error)") }
    }
}


private enum TEnum: CaseIterable, ScaleCodable {
    case c1
    case c2
    case c3
}
