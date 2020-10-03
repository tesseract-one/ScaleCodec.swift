//
//  StructTests.swift
//  
//
//  Created by Yehor Popovych on 10/3/20.
//

import XCTest
import ScaleCodec


final class StructTests: XCTestCase {
    func testWrappedValue() {
        let value = Wrapper(3)
        let encoded = "0c"
        RunEncDecTests([(value, encoded)])
    }
    
    func testSimpleStruct() {
        let tests: [(SimpleStruct, String)] = [
            (SimpleStruct((nil, nil), ""), "00 00 00"),
            (SimpleStruct((nil, Int32.max), "Hello"), "00 01 ff ff ff 7f 14 48 65 6c 6c 6f"),
            (SimpleStruct(("Hello", Int32.max), ""), "01 14 48 65 6c 6c 6f 01 ff ff ff 7f 00"),
            (SimpleStruct(("Hello", nil), "World!"), "01 14 48 65 6c 6c 6f 00 18 57 6f 72 6c 64 21"),
            (SimpleStruct(("Hello", Int32.max), "World!"),
             "01 14 48 65 6c 6c 6f 01 ff ff ff 7f 18 57 6f 72 6c 64 21")
        ]
        RunEncDecTests(tests)
    }
    
    func testComplexStuct() {
        let strct1 = ComplexStruct(
            i8: Int8.min, i16: Int16.min, i32: Int32.min, u32: UInt32.max, i64: Int64.min,
            u64: UInt64.max, i128: BigInt(-2).power(127), u128: BigUInt(2).power(128) - 1,
            c8: UInt8.max, c16: UInt16.max, c64: UInt64.max, cb: BigUInt(2).power(128) - 1,
            enm: .c1("Hello"), earr: [.c1(nil), .c2(Int32.min, true)],
            carrarr: [[0], [UInt32.max, 0, UInt32.max], []],
            strct: SimpleStruct(("Hello", Int32.max), "World!")
        )
        let encoded1 = """
        80 00 80 00 00 00 80 ff ff ff ff 00 00 00 00 00 00 00 80 ff ff ff ff ff ff ff ff 00 00 \
        00 00 00 00 00 00 00 00 00 00 00 00 00 80 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff \
        ff fd 03 fe ff 03 00 13 ff ff ff ff ff ff ff ff 33 ff ff ff ff ff ff ff ff ff ff ff ff \
        ff ff ff ff 00 01 14 48 65 6c 6c 6f 08 00 00 01 00 00 00 80 02 0c 04 00 0c 03 ff ff ff \
        ff 00 03 ff ff ff ff 00 01 14 48 65 6c 6c 6f 01 ff ff ff 7f 18 57 6f 72 6c 64 21
        """
        let strct2 = ComplexStruct(
            i8: Int8.max, i16: Int16.max, i32: Int32.max, u32: 0, i64: Int64.max,
            u64: 0, i128: BigInt(2).power(127) - 1, u128: 0,
            c8: 0, c16: 0, c64: 0, cb: 0,
            enm: .c1(nil), earr: [.c1("Hello"), .c2(Int32.max, nil)],
            carrarr: [[0, UInt32.max], [UInt32.max]],
            strct: SimpleStruct((nil, Int32.min), "")
        )
        let encoded2 = """
        7f ff 7f ff ff ff 7f 00 00 00 00 ff ff ff ff ff ff ff 7f 00 00 00 00 00 00 00 00 ff ff \
        ff ff ff ff ff ff ff ff ff ff ff ff ff 7f 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 \
        00 00 00 00 00 00 00 08 00 01 14 48 65 6c 6c 6f 01 ff ff ff 7f 00 08 08 00 03 ff ff ff \
        ff 04 03 ff ff ff ff 00 01 00 00 00 80 00
        """
        RunEncDecTests([(strct1, encoded1), (strct2, encoded2)])
    }
}

private struct ComplexStruct: Equatable, ScaleCodable {
    let i8: Int8
    let i16: Int16
    let i32: Int32
    let u32: UInt32
    let i64: Int64
    let u64: UInt64
    let i128: BigInt
    let u128: BigUInt
    let c8: UInt8
    let c16: UInt16
    let c64: UInt64
    let cb: BigUInt
    let enm: TDataEnum
    let earr: Array<TDataEnum>
    let carrarr: Array<Array<UInt32>>
    let strct: SimpleStruct
    
    init(
        i8: Int8, i16: Int16, i32: Int32, u32: UInt32, i64: Int64, u64: UInt64, i128: BigInt,
        u128: BigUInt, c8: UInt8, c16: UInt16, c64: UInt64, cb: BigUInt, enm: TDataEnum,
        earr: Array<TDataEnum>, carrarr: Array<Array<UInt32>>, strct: SimpleStruct
    ) {
        self.i8 = i8; self.i16 = i16; self.i32 = i32; self.u32 = u32; self.i64 = i64
        self.u64 = u64; self.i128 = i128; self.u128 = u128; self.c8 = c8; self.c16 = c16
        self.c64 = c64; self.cb = cb; self.enm = enm; self.earr = earr
        self.carrarr = carrarr; self.strct = strct
    }
    
    init(from decoder: ScaleDecoder) throws {
        i8 = try decoder.decode(); i16 = try decoder.decode()
        i32 = try decoder.decode(); u32 = try decoder.decode()
        i64 = try decoder.decode(); u64 = try decoder.decode()
        i128 = try decoder.decode(); u128 = try decoder.decode()
        c8 = try decoder.decodeCompact(); c16 = try decoder.decodeCompact()
        c64 = try decoder.decodeCompact(); cb = try decoder.decodeCompact()
        enm = try decoder.decode(); earr = try decoder.decode()
        let sarr = try decoder.decode(Array<Array<SCompact<UInt32>>>.self)
        carrarr = sarr.map { $0.map { $0.value } }
        strct = try decoder.decode()
    }
    
    func encode(in encoder: ScaleEncoder) throws {
        let sarr = carrarr.map { $0.map { SCompact($0) } }
        try encoder.encode(i8).encode(i16).encode(i32)
            .encode(u32).encode(i64).encode(u64).encode(i128)
            .encode(u128).encodeCompact(c8).encodeCompact(c16)
            .encodeCompact(c64).encodeCompact(cb).encode(enm)
            .encode(earr).encode(sarr).encode(strct)
    }
    
}

private struct SimpleStruct: ScaleCodable, Equatable {
    let tuple: (String?, Int32?)
    let str: String
    
    static func == (lhs: SimpleStruct, rhs: SimpleStruct) -> Bool {
        return lhs.tuple == rhs.tuple && lhs.str == rhs.str
    }
    
    init(_ tuple: (String?, Int32?), _ str: String) {
        self.tuple = tuple
        self.str = str
    }
    
    init(from decoder: ScaleDecoder) throws {
        tuple = try decoder.decode()
        str = try decoder.decode()
    }
    
    func encode(in encoder: ScaleEncoder) throws {
        try encoder.encode(tuple).encode(str)
    }
}

private struct Wrapper: ScaleCodable, Equatable {
    let wrapped: UInt32
    
    init(_ value: UInt32) {
        wrapped = value
    }
    
    init(from decoder: ScaleDecoder) throws {
        wrapped = try decoder.decodeCompact()
    }
    
    func encode(in encoder: ScaleEncoder) throws {
        try encoder.encodeCompact(wrapped)
    }
}

private enum TDataEnum: ScaleCodable, Equatable {
    case c1(String?)
    case c2(Int32, Bool?)
    
    init(from decoder: ScaleDecoder) throws {
        let opt = try decoder.decodeEnumCaseId()
        switch opt {
        case 0: self = try .c1(decoder.decode())
        case 1: self = try .c2(decoder.decode(), decoder.decode())
        default: throw decoder.enumCaseError(for: opt)
        }
    }
    
    func encode(in encoder: ScaleEncoder) throws {
        switch self {
        case .c1(let str): try encoder.encodeEnumCaseId(0).encode(str)
        case .c2(let int, let obool): try encoder.encodeEnumCaseId(1).encode(int).encode(obool)
        }
    }
}
