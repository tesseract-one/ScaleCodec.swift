//
//  StringTests.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import XCTest
import ScaleCodec

final class StringTests: XCTestCase {
    func testEncodingDecoding() {
        let value = "Hello, World!"
        let encoded = "34 48 65 6c 6c 6f 2c 20 57 6f 72 6c 64 21"
        RunEncDecTests([(value, encoded)])
    }
    
    func testUTF8() {
        let values = [
            ("Hamlet", "18 48 61 6d 6c 65 74"),
            ("Война и мир", "50 d0 92 d0 be d0 b9 d0 bd d0 b0 20 d0 b8 20 d0 bc d0 b8 d1 80"),
            ("三国演义", "30 e4 b8 89 e5 9b bd e6 bc 94 e4 b9 89"),
            ("أَلْف لَيْلَة وَلَيْلَة‎", "bc d8 a3 d9 8e d9 84 d9 92 d9 81 20 d9 84 d9 8e d9 8a d9 92 d9 84 d9 8e d8 a9 20 d9 88 d9 8e d9 84 d9 8e d9 8a d9 92 d9 84 d9 8e d8 a9 e2 80 8e")
        ];
        RunEncDecTests(values)
    }
    
    func testBadUTF8() {
        let encoded = Data([20, 114, 167, 10, 20, 114]);
        XCTAssertThrowsError(try ScaleCodec.decode(String.self, from: encoded))
    }
    
    func testCharacter() {
        let values = [
            (Character("A"), "41 00 00 00"),
            (Character(UnicodeScalar(0)), "00 00 00 00"),
            (Character(UnicodeScalar(UInt16(0xD7FF))!), "ff d7 00 00"),
            (Character(UnicodeScalar(UInt16(0xE000))!), "00 e0 00 00"),
            (Character(UnicodeScalar(UInt32(0x10FFFF))!), "ff ff 10 00"),
            (Character("é"), "e9 00 00 00"),
            (Character("🐥"), "25 f4 01 00")
        ]
        RunEncDecTests(values)
    }
    
    func testBadCharacter() {
        XCTAssertThrowsError(try ScaleCodec.decode(Character.self, from: "ff ff 11 00".hexData!))
        XCTAssertThrowsError(try ScaleCodec.decode(Character.self, from: "ff d8 00 00".hexData!))
    }
}
