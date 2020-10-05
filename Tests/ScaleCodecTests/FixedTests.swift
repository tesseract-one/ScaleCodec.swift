//
//  FixedTests.swift
//  
//
//  Created by Yehor Popovych on 10/5/20.
//

import XCTest
import ScaleCodec

final class FixedTests: XCTestCase {
    func testFixedStringArrayStruct() {
        let tests: [(TStringArray4, String)] = [
            (TStringArray4(["1", "2", "3", "4"]), "04 31 04 32 04 33 04 34"),
            (TStringArray4(["3", "1", "4", "2"]), "04 33 04 31 04 34 04 32")
        ]
        RunEncDecTests(tests)
    }
    
    func testFixedDataStruct() {
        let tests: [(THash, String)] = [
            (THash(Data([1, 2, 3, 4])), "01 02 03 04"),
            (THash(Data([255, 0, 255, 0])), "ff 00 ff 00")
        ]
        RunEncDecTests(tests)
    }
    
    func testDataStructBadSizeErrors() {
        XCTAssertThrowsError(try SCALE.default.encode(THash(Data([0, 1, 2]))))
        XCTAssertThrowsError(try SCALE.default.encode(THash(Data([0, 1, 2, 3, 4]))))
    }
    
    func testArrayStructBadSizeErrors() {
        XCTAssertThrowsError(try SCALE.default.encode(TStringArray4(["1", "2", "3"])))
        XCTAssertThrowsError(try SCALE.default.encode(TStringArray4(["1", "2", "3", "4", "5"])))
    }
}

private struct TStringArray4: Equatable {
    var array: [String]
    
    init(_ array: [String]) {
        self.array = array
    }
}

extension TStringArray4: ScaleFixed {
    typealias Element = String
    
    static var fixedElementCount: Int = 4
    
    init(decoding values: [String]) throws {
        self.init(values)
    }
    
    func encode() throws -> [String] {
        return self.array
    }
}

private struct THash: Equatable {
    var data: Data
    
    init(_ data: Data) {
        self.data = data
    }
}

extension THash: ScaleFixedData {
    static var fixedBytesCount: Int = 4
    
    init(decoding data: Data) throws {
        self.init(data)
    }
    
    func encode() throws -> Data {
        return self.data
    }
}
