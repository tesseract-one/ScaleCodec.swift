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
            (true, "01"),
            (false, "02")
        ]
        RunEncDecTests(tests)
        XCTAssertThrowsError(try ScaleCodec.decode(Optional<Bool>.self, from: Data([0x03])))
    }
    
    func testInt() {
        do {
            let tests: [(Int32?, String)] = [
                (nil, "00"),
                (Int32.min, "01 \(try ScaleCodec.encode(Int32.min).hex)"),
                (0, "01 \(try ScaleCodec.encode(Int32(0)).hex)"),
                (Int32.max, "01 \(try ScaleCodec.encode(Int32.max).hex)")
            ]
            RunEncDecTests(tests)
        } catch { XCTFail("\(error)") }
    }
    
    func testString() {
        do {
            let tests: [(String?, String)] = [
                (nil, "00"),
                ("Hello", "01 \(try ScaleCodec.encode("Hello").hex)"),
                ("World!", "01 \(try ScaleCodec.encode("World!").hex)"),
                ("", "01 \(try ScaleCodec.encode("").hex)")
            ]
            RunEncDecTests(tests)
        } catch { XCTFail("\(error)") }
    }
    
    func testArray() {
        do {
            let tests1: [([TEnum]?, String)] = [
                (nil, "00"),
                ([TEnum.c1, TEnum.c2], "01 \(try ScaleCodec.encode([TEnum.c1, TEnum.c2]).hex)"),
            ]
            let tests2: [([UInt32]?, String)] = [
                (nil, "00"),
                ([UInt32(100), UInt32(256), UInt32.min, UInt32.max],
                 "01 \(try ScaleCodec.encode([UInt32(100), UInt32(256), UInt32.min, UInt32.max]).hex)"),
            ]
            let tests3: [([String]?, String)] = [
                (nil, "00"),
                (["Hello", "World!", ""], "01 \(try ScaleCodec.encode(["Hello", "World!", ""]).hex)"),
            ]
            RunEncDecTests(tests1)
            RunEncDecTests(tests2)
            RunEncDecTests(tests3)
        } catch { XCTFail("\(error)") }
    }
    
    func testEnum() {
        do {
            let tests: [(TEnum?, String)] = [
                (nil, "00"),
                (.c1, "01 \(try ScaleCodec.encode(TEnum.c1).hex)"),
                (.c2, "01 \(try ScaleCodec.encode(TEnum.c2).hex)"),
                (.c3, "01 \(try ScaleCodec.encode(TEnum.c3).hex)")
            ]
            RunEncDecTests(tests)
        } catch { XCTFail("\(error)") }
    }
    
    func testDataEnum() {
        do {
            let tests: [(TDataEnum?, String)] = [
                (nil, "00"),
                (.c1(-128), "01 \(try ScaleCodec.encode(TDataEnum.c1(-128)).hex)"),
                (.c2(UInt64.compactMax), "01 \(try ScaleCodec.encode(TDataEnum.c2(UInt64.compactMax)).hex)"),
                (.c3(.c2), "01 \(try ScaleCodec.encode(TDataEnum.c3(.c2)).hex)")
            ]
            RunEncDecTests(tests)
        } catch { XCTFail("\(error)") }
    }
    
    func testOptionalBool() {
        let tests: [(Optional<Bool>?, String)] = [
            (nil, "00"),
            (.some(nil), "01 00"),
            (true, "01 01"),
            (false, "01 02"),
        ]
        RunEncDecTests(tests)
    }
    
    func testOptionalString() {
        do {
            let tests: [(Optional<String>?, String)] = [
                (nil, "00"),
                (.some(nil), "01 00"),
                ("Hello", "01 01 \(try ScaleCodec.encode("Hello").hex)"),
                ("World!", "01 01 \(try ScaleCodec.encode("World!").hex)"),
                ("", "01 01 \(try ScaleCodec.encode("").hex)")
            ]
            RunEncDecTests(tests)
        } catch { XCTFail("\(error)") }
    }
}

private enum TEnum: CaseIterable, Codable {
    case c1
    case c2
    case c3
}

private enum TDataEnum: Codable, Equatable {
    case c1(Int32)
    case c2(UInt64)
    case c3(TEnum)
    
    init<D: Decoder>(from decoder: inout D) throws {
        let opt = try decoder.decode(.enumCaseId)
        switch opt {
        case 0: self = try .c1(decoder.decode())
        case 1: self = try .c2(decoder.decode(.compact))
        case 2: self = try .c3(decoder.decode())
        default: throw decoder.enumCaseError(for: opt)
        }
    }
    
    func encode<E: Encoder>(in encoder: inout E) throws {
        switch self {
        case .c1(let int):
            try encoder.encode(0, .enumCaseId)
            try encoder.encode(int)
        case .c2(let buint):
            try encoder.encode(1, .enumCaseId)
            try encoder.encode(buint, .compact)
        case .c3(let enm):
            try encoder.encode(2, .enumCaseId)
            try encoder.encode(enm)
        }
    }
}
