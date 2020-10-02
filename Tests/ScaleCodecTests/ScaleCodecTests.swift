import XCTest
@testable import ScaleCodec

struct TestData {
    let var1: UInt32
    let var2: Int16
    let var3: BigUInt
    let var4: UInt8
    let evar: (TestEnum, Int8, Int32)
    let avar: [TestEnum]
    let obvar: Bool?
    let ovar: Optional<TestEnum>
}

extension TestData: ScaleCodable {
    init(from decoder: ScaleDecoder) throws {
        var1 = try decoder.decode()
        var2 = try decoder.decode()
        var3 = try decoder.decodeCompact()
        var4 = try decoder.decode()
        evar = try decoder.decode()
        avar = try decoder.decode()
        obvar = try decoder.decodeOptBool()
        ovar = try decoder.decode()
    }
    
    func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(var1).encode(var2)
            .encodeCompact(var3).encode(var4)
            .encode(evar).encode(avar)
            .encodeOptBool(obvar).encode(ovar)
    }
}

enum TestEnum: CaseIterable, ScaleCodable {
    case c1
    case c2
    case c3
}

final class ScaleCodecTests: XCTestCase {
    
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
    
    func testInt128() {
        let int128_min_d = Data(repeating: 0x00, count: 15) + Data([0x80])
        let int128_max_d = Data(repeating: 0xff, count: 15) + Data([0x7f])
        let int128_0_d = Data(repeating: 0x00, count: 16)
        let int128_m1_d = Data(repeating: 0xff, count: 16)
        let int128_m2_d = Data([0xfe]) + Data(repeating: 0xff, count: 15)
        
        let int128_min = BigInt(sign: .minus, magnitude: BigUInt(2).power(127))
        let int128_max = BigInt(2).power(127) - 1
        let int128_0 = BigInt(0)
        let int128_m1 = BigInt(-1)
        let int128_m2 = BigInt(-2)
        
        do {
            let max_enc = try SCALE.default.encode(int128_max)
            let min_enc = try SCALE.default.encode(int128_min)
            let enc_0 = try SCALE.default.encode(int128_0)
            let enc_m1 = try SCALE.default.encode(int128_m1)
            let enc_m2 = try SCALE.default.encode(int128_m2)
            XCTAssertEqual(max_enc, int128_max_d)
            XCTAssertEqual(min_enc, int128_min_d)
            XCTAssertEqual(enc_0, int128_0_d)
            XCTAssertEqual(enc_m1, int128_m1_d)
            XCTAssertEqual(enc_m2, int128_m2_d)
            let min = try SCALE.default.decode(BigInt.self, from: int128_min_d)
            let max = try SCALE.default.decode(BigInt.self, from: int128_max_d)
            let _0 = try SCALE.default.decode(BigInt.self, from: int128_0_d)
            let m1 = try SCALE.default.decode(BigInt.self, from: int128_m1_d)
            let m2 = try SCALE.default.decode(BigInt.self, from: int128_m2_d)
            XCTAssertEqual(min, int128_min)
            XCTAssertEqual(max, int128_max)
            XCTAssertEqual(_0, int128_0)
            XCTAssertEqual(m1, int128_m1)
            XCTAssertEqual(m2, int128_m2)
        } catch {
            XCTFail("\(error)")
        }
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let test = TestData(
            var1: 1, var2: 3, var3: BigUInt(3).power(256),
            var4: 4, evar: (.c2, 5, 6), avar: [.c3, .c1, .c2],
            obvar: false, ovar: .c3
        )
        let data = try! SCALE.default.encode(test)
        print(data.reduce("") {$0 + String(format: "%02x", $1)})
        let test2 = try! SCALE.default.decode(TestData.self, from: data)
        print(test2)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
