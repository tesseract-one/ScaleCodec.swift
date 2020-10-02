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
        obvar = try decoder.decode()
        ovar = try decoder.decode()
    }
    
    func encode(in encoder: ScaleEncoder) throws {
        try encoder
            .encode(var1).encode(var2)
            .encodeCompact(var3).encode(var4)
            .encode(evar).encode(avar)
            .encode(obvar).encode(ovar)
    }
}

enum TestEnum: CaseIterable, ScaleCodable {
    case c1
    case c2
    case c3
}

final class ScaleCodecTests: XCTestCase {
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
