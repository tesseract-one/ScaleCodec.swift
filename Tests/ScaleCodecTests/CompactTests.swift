//
//  CompactTests.swift
//  
//
//  Created by Yehor Popovych on 10/2/20.
//

import XCTest
import ScaleCodec

final class CompactTests: XCTestCase {
    func testCompactUInt64() {
        let tests: [(UInt64, Data)] = [
            (0, Data([0x00])),
            (63, Data([0xfc])),
            (64, Data([0x01, 0x01])),
            (16383, Data([0xfd, 0xff])),
            (16384, Data([0x02, 0x00, 0x01, 0x00])),
            (1073741823, Data([0xfe, 0xff, 0xff, 0xff])),
            (1073741824, Data([0x03, 0x00, 0x00, 0x00, 0x40])),
            ((1 << 32) - 1, Data([0x03, 0xff, 0xff, 0xff, 0xff])),
            (1 << 32, Data([0x07, 0x00, 0x00, 0x00, 0x00, 0x01])),
            (1 << 40, Data([0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01])),
            (1 << 48, Data([0x0f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01])),
            ((1 << 56) - 1, Data([0x0f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff])),
            (1 << 56, Data([0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01])),
            (UInt64.max, Data([0x13, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff]))
        ]
        let codec = SCALE()
        
        for (v, d) in tests {
            do {
                let data = try codec.encode(SCompact(v))
                let decoded = try codec.decode(SCompact<UInt64>.self, from: d).value
                XCTAssertEqual(data, d)
                XCTAssertEqual(decoded, v)
            } catch {
                XCTFail("\(error)")
            }
        }
    }
    
    func testCompactUInt128() {
        let tests: [(BigUInt, Data)] = [
            (0, Data([0x00])),
            (63, Data([0xfc])),
            (64, Data([0x01, 0x01])),
            (16383, Data([0xfd, 0xff])),
            (16384, Data([0x02, 0x00, 0x01, 0x00])),
            (1073741823, Data([0xfe, 0xff, 0xff, 0xff])),
            (1073741824, Data([0x03, 0x00, 0x00, 0x00, 0x40])),
            ((1 << 32) - 1, Data([0x03, 0xff, 0xff, 0xff, 0xff])),
            (1 << 32, Data([0x07, 0x00, 0x00, 0x00, 0x00, 0x01])),
            (1 << 40, Data([0x0b, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01])),
            (1 << 48, Data([0x0f, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01])),
            ((1 << 56) - 1, Data([0x0f, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff])),
            (1 << 56, Data([0x13, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01])),
            (BigUInt(UInt64.max), Data([0x13, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff, 0xff]))
        ]
        let codec = SCALE()
        
        for (v, d) in tests {
            do {
                let data = try codec.encode(SCompact(v))
                let decoded = try codec.decode(SCompact<BigUInt>.self, from: d).value
                XCTAssertEqual(data, d)
                XCTAssertEqual(decoded, v)
            } catch {
                XCTFail("\(error)")
            }
        }
    }
}
