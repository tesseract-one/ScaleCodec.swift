//
//  EnumTests.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import XCTest
import ScaleCodec

final class EnumTests: XCTestCase {
    
    func testSimpleCaseEnum() {
        let values: [(TEnum, String)] = [
            (.c1, "00"),
            (.c2, "01"),
            (.c3, "02"),
            (.c4, "03"),
            (.c5, "04")
        ]
        RunEncDecTests(values)
    }
    
    func testAssociatedValues() {
        let values: [(TDataEnum, String)] = [
            (.c1(54321), "00 c6 50 03 00"),
            (.c2(true), "01 01"),
            (.c3("Hello", -654321), "02 14 48 65 6c 6c 6f 0f 04 f6 ff"),
            (.c4("World!"), "03 01 18 57 6f 72 6c 64 21"),
            (.c5([.c1, .c3, .c5, .c2]), "04 10 00 02 04 01")
        ]
        RunEncDecTests(values)
    }
    
    func testSimpleBadCaseId() {
        XCTAssertThrowsError(try ScaleCodec.decode(TEnum.self, from: "ff".hexData!))
    }
}


private enum TEnum: CaseIterable, Codable {
    case c1
    case c2
    case c3
    case c4
    case c5
}

private enum TDataEnum: Codable, Equatable {
    case c1(UInt16)
    case c2(Bool?)
    case c3(String, Int32)
    case c4(String?)
    case c5([TEnum])
    
    init<D: Decoder>(from decoder: inout D) throws {
        let opt = try decoder.decode(.enumCaseId)
        switch opt {
        case 0: self = try .c1(decoder.decode(.compact))
        case 1: self = try .c2(decoder.decode())
        case 2: self = try .c3(decoder.decode(), decoder.decode())
        case 3: self = try .c4(decoder.decode())
        case 4: self = try .c5(decoder.decode())
        default: throw decoder.enumCaseError(for: opt)
        }
    }
    
    func encode<E: Encoder>(in encoder: inout E) throws {
        switch self {
        case .c1(let uint):
            try encoder.encode(0, .enumCaseId)
            try encoder.encode(uint, .compact)
        case .c2(let opt):
            try encoder.encode(1, .enumCaseId)
            try encoder.encode(opt)
        case .c3(let str, let int):
            try encoder.encode(2, .enumCaseId)
            try encoder.encode(str)
            try encoder.encode(int)
        case .c4(let ostr):
            try encoder.encode(3, .enumCaseId)
            try encoder.encode(ostr)
        case .c5(let arr):
            try encoder.encode(4, .enumCaseId)
            try encoder.encode(arr)
        }
    }
}
