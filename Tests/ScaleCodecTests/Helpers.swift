//
//  Helpers.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import XCTest
import ScaleCodec

enum TEnum: CaseIterable, ScaleCodable {
    case c1
    case c2
    case c3
    case c4
    case c5
}

enum TDataEnum: ScaleCodable {
    case c1(UInt16)
    case c2(Bool?)
    case c3(String, Int32)
    case c4(String?)
    case c5([TEnum])
    
    init(from decoder: ScaleDecoder) throws {
        let opt = try decoder.decodeEnumCaseId()
        switch opt {
        case 0: self = try .c1(decoder.decodeCompact())
        case 1: self = try .c2(decoder.decodeOptBool())
        case 2: self = try .c3(decoder.decode(), decoder.decode())
        case 3: self = try .c4(decoder.decode())
        case 4: self = try .c5(decoder.decode())
        default: throw decoder.enumCaseError(for: opt)
        }
    }
    
    func encode(in encoder: ScaleEncoder) throws {
        switch self {
        case .c1(let uint): try encoder.encodeEnumCaseId(0).encode(uint)
        case .c2(let opt): try encoder.encodeEnumCaseId(1).encodeOptBool(opt)
        case .c3(let tuple): try encoder.encodeEnumCaseId(2).encode(tuple)
        case .c4(let ostr): try encoder.encodeEnumCaseId(3).encode(ostr)
        case .c5(let arr): try encoder.encodeEnumCaseId(4).encode(arr)
        }
    }
}


extension Data {
    init?(hex: String) {
        let hexString = hex.replacingOccurrences(of: " ", with: "").dropFirst(hex.hasPrefix("0x") ? 2 : 0)
        let len = hexString.count / 2
        var data = Data(capacity: len)
        for i in 0..<len {
            let j = hexString.index(hexString.startIndex, offsetBy: i*2)
            let k = hexString.index(j, offsetBy: 2)
            let bytes = hexString[j..<k]
            if var num = UInt8(bytes, radix: 16) {
                data.append(&num, count: 1)
            } else {
                return nil
            }
        }
        self = data
    }
    
    var hex: String {
        self.map { String(format: "%02x", $0) }.joined(separator: " ")
    }
}

extension String {
    var hexData: Data? {
        return Data(hex: self)
    }
}

func XCTAssertNoThrowS<T>(_ expression: @autoclosure () throws -> T, _ message: @autoclosure () -> String = "", file: StaticString = #file, line: UInt = #line) -> T? {
    do {
        return try expression()
    } catch {
        let m = message()
        if m != "" {
            XCTFail("\(m) with \(error)", file: file, line: line)
        } else {
            XCTFail("\(error)", file: file, line: line)
        }
        return nil
    }
}
