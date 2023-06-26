//
//  TupleTests.swift
//  
//
//  Created by Yehor Popovych on 10/3/20.
//

import XCTest
import ScaleCodec

final class TupleTests: XCTestCase {
    
    func testTuple2() {
        do {
            let d1 = try ScaleCodec.encode((UInt8.min, UInt8.max))
            XCTAssertEqual(d1.hex, "00 ff")
            let t1 = try ScaleCodec.decode((UInt8, UInt8).self, from: d1)
            XCTAssertEqual(t1.0, UInt8.min)
            XCTAssertEqual(t1.1, UInt8.max)
        } catch { XCTFail("\(error)") }
    }
    
    func testTuple3() {
        do {
            let d1 = try ScaleCodec.encode((UInt8.min, UInt8(128), UInt8.max))
            XCTAssertEqual(d1.hex, "00 80 ff")
            let t1 = try ScaleCodec.decode((UInt8, UInt8, UInt8).self, from: d1)
            XCTAssertEqual(t1.0, UInt8.min)
            XCTAssertEqual(t1.1, 128)
            XCTAssertEqual(t1.2, UInt8.max)
        } catch { XCTFail("\(error)") }
    }
    
    func testTuple4() {
        do {
            let d1 = try ScaleCodec.encode((UInt8.min, UInt8(127), UInt8(128), UInt8.max))
            XCTAssertEqual(d1.hex, "00 7f 80 ff")
            let t1 = try ScaleCodec.decode((UInt8, UInt8, UInt8, UInt8).self, from: d1)
            XCTAssertEqual(t1.0, UInt8.min)
            XCTAssertEqual(t1.1, 127)
            XCTAssertEqual(t1.2, 128)
            XCTAssertEqual(t1.3, UInt8.max)
        } catch { XCTFail("\(error)") }
    }
    
    func testTuple5() {
        do {
            let d1 = try ScaleCodec.encode((UInt8.min, UInt8(127), UInt8(128), UInt8(129), UInt8.max))
            XCTAssertEqual(d1.hex, "00 7f 80 81 ff")
            let t1 = try ScaleCodec.decode((UInt8, UInt8, UInt8, UInt8, UInt8).self, from: d1)
            XCTAssertEqual(t1.0, UInt8.min)
            XCTAssertEqual(t1.1, 127)
            XCTAssertEqual(t1.2, 128)
            XCTAssertEqual(t1.3, 129)
            XCTAssertEqual(t1.4, UInt8.max)
        } catch { XCTFail("\(error)") }
    }
    
    func testTupleNestedContainers() {
        do {
            let d1 = try ScaleCodec.encode(
                (
                    Optional<Int8>(.min), Result<UInt8, TError>.success(.max),
                    [UInt8(128)], ["Test": UInt8.max]
                )
            )
            XCTAssertEqual(d1.hex, "01 80 00 ff 04 80 04 10 54 65 73 74 ff")
            let t1 = try ScaleCodec.decode(
                (Optional<Int8>, Result<UInt8, TError>, [UInt8], [String: UInt8]).self,
                from: d1
            )
            XCTAssertEqual(t1.0, .min)
            XCTAssertEqual(t1.1, .success(.max))
            XCTAssertEqual(t1.2, [UInt8(128)])
            XCTAssertEqual(t1.3, ["Test": UInt8.max])
        } catch { XCTFail("\(error)") }
    }
}

private enum TError: CaseIterable, Error, Codable {
    case err
}
