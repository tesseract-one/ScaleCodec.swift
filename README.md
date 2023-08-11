# Swift SCALE Codec

![🐧 linux: ready](https://img.shields.io/badge/%F0%9F%90%A7%20linux-ready-red.svg)
[![GitHub license](https://img.shields.io/badge/license-Apache%202.0-lightgrey.svg)](LICENSE)
[![Build Status](https://github.com/tesseract-one/ScaleCodec.swift/workflows/CI/badge.svg?branch=main)](https://github.com/tesseract-one/ScaleCodec.swift/actions?query=workflow%3ACI+branch%3Amain)
[![GitHub release](https://img.shields.io/github/release/tesseract-one/ScaleCodec.swift.svg)](https://github.com/tesseract-one/ScaleCodec.swift/releases)
[![SPM compatible](https://img.shields.io/badge/SwiftPM-Compatible-brightgreen.svg)](https://swift.org/package-manager/)
[![CocoaPods version](https://img.shields.io/cocoapods/v/ScaleCodec.svg)](https://cocoapods.org/pods/ScaleCodec)
![Platform OS X | iOS | tvOS | watchOS | Linux](https://img.shields.io/badge/platform-Linux%20%7C%20OS%20X%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-orange.svg)

Swift implementation of the SCALE (Simple Concatenated Aggregate Little-Endian) data format
for types used in the Parity Substrate framework.

SCALE is a light-weight format which allows encoding (and decoding) which makes it highly
suitable for resource-constrained execution environments like blockchain runtimes and low-power,
low-memory devices.

It is important to note that the encoding context (knowledge of how the types and data structures look)
needs to be known separately at both encoding and decoding ends.
The encoded data does not include this contextual information.

To get a better understanding of how the encoding is done for different types,
take a look at the
[low-level data formats overview page at the Substrate docs site](https://substrate.dev/docs/en/knowledgebase/advanced/codec).

## Installation

ScaleCodec deploys to macOS 10.10, iOS 9, watchOS 2, tvOS 9 and Linux. It has been tested on the latest OS releases only however, as the module uses very few platform-provided APIs, there should be very few issues with earlier versions.

ScaleCodec uses no APIs specific to Apple platforms, so it should be easy to port it to other operating systems.

Setup instructions:

- **Swift Package Manager:**
  Add this to the dependency section of your `Package.swift` manifest:

    ```Swift
    .package(url: "https://github.com/tesseract-one/ScaleCodec.swift.git", from: "0.3.0")
    ```

- **CocoaPods:** Put this in your `Podfile`:

    ```Ruby
    pod 'ScaleCodec', '~> 0.3'
    ```

## Usage Examples

Following are some examples to demonstrate usage of the codec.

### Simple Types

Codec supports `String`, `Data`, `Bool`, `Int[8-64]` and `UInt[8-64]` types.

```Swift
import ScaleCodec

let data = Data([0xff, 0xff, 0xff, 0xff])

let encoded = try encode(UInt32.max)
assert(encoded == data)

let uint32 = try decode(UInt32.self, from: data)
assert(uint32 == UInt32.max)
```

#### Compact encoding

`UInt[8-64]`, `SUInt[128-512]` and  `BigUInt` types can be encoded with compact encoding. This allows `BigUInt` to store values up to `2^536-1`.

ScaleCodec has special wrapper type `SCompact` which encodes and decodes values in this format and two helper methods.

Example:

```Swift
import ScaleCodec

let data = Data([0x07, 0x00, 0x00, 0x00, 0x00, 0x01])

let encoded = try encode(UInt64(1 << 32), .compact)
assert(encoded == data))

let compact = try decode(UInt64.self, .compact, from: data)
assert(compact == UInt64(1 << 32))

// without custom encoding methods
// let encoded = try encode(Compact(UInt64(1 << 32)))
// let compact = try decode(Compact<UInt64>.self, from: data).value
```

#### Data fixed encoding

`Data` type can be encoded with fixed encoding. In this mode data length will not be stored so length should be provided manually.

```Swift
import ScaleCodec

let data = Data([0x07, 0x00, 0x00, 0x00, 0x00, 0x01]

var encoder = encoder()
try encoder.encode(data, .fixed(6))
assert(encoder.output == data))

var decoder = decoder(from: encoder.output)
let decoded = try decoder.decode(Data.self, .fixed(6))
assert(decoded == encoder.output == data)
```

### Container types

ScaleCodec can encode and decode standard containers. Supported containers: `Optional`, `Result`, `Array`, `Set`, `Dictionary`. Containers can be nested in each other. Container element should be encodable.

```Swift
import ScaleCodec

let array: [UInt32] = [1, 2, 3, 4, 5]

let data = try encode(array)

let decoded: [UInt32] = try decode(from: data)

assert(array == decoded)
```

#### Fixed Arrays

`Array` can be encoded in fixed encoding the same way as `Data`. Length should be provided manually.

```Swift
import ScaleCodec

let array: [UInt32] = [1, 2, 3, 4, 5]

let data = try encode(array, .fixed(5))

let decoded: [UInt32] = try decode(.fixed(5), from: data)

assert(array == decoded)
```

### Tuples

Tuple encoding and decoding supported through `Tuple*` set of wrappers. ScaleCodec provides `Tuple()` helper which can create approptiate `Tuple*` instance for a tuple. `Tuple*` wrappers can be nested to support bigger tuples. ScaleCodec also has set of helper methods for tuples support. 

```Swift
import ScaleCodec

let tuple = (UInt32.max, "Hello")

let encoded = try encode(tuple)

let decoded: (UInt32, String) = try decode(from: encoded)

assert(tuple == decoded)

// without helper methods
// let encoded = try encode(Tuple(tuple)) // or directly Tuple2(tuple)
// let decoded = try decode(Tuple2<UInt32, String>.self, from: encoded).tuple
```

### Enums

#### Simple enums

Simple enums without associated values can be encoded automatically if enum supports `CaseIterable` protocol. Swift has autoimplementation feature for `CaseIterable` protocol for simple enums.

```Swift
import ScaleCodec

enum Test: CaseIterable, ScaleCodec.Codable {
  case A
  case B
}

let data = try encode(Test.A)

let decoded: Test = try decode(from: data)

assert(decoded == Test.A)
```

#### Complex enums

Encoding and decoding for complex enums with associated values should be implemented manually. Two protocols need to be implemented: `Encodable` and `Decodable` (`Codable` can be used as common alias).

```Swift
import ScaleCodec

enum Test: ScaleCodec.Codable {
  case A(String?)
  case B(UInt32, String) // UInt32 will use Compact encoding.
  
  init<D: ScaleCodec.Decoder>(from decoder: inout D) throws {
    let opt = try decoder.decode(.enumCaseId)
    switch opt {
    case 0: self = try .A(decoder.decode())
    case 1: self = try .B(decoder.decode(.compact), decoder.decode())
    default: throw decoder.enumCaseError(for: opt)
    }
  }
  
  func encode<E: ScaleCodec.Encoder>(in encoder: inout E) throws {
    switch self {
    case .A(let str):
      try encoder.encode(0, .enumCaseId)
      try encoder.encode(str)
    case .B(let int, let str):
      try encoder.encode(1, .enumCaseId)
      try encoder.encode(int, .compact)
      try encoder.encode(str)
    }
  }
}

let val = Test.B(100, "World!")

let data = try encode(val)

let decoded: Test = try decode(from: data)

assert(decoded == val)
```

### Classes and Structures

`Encodable` and `Decodable` should be implemented for classes and structures. `Encoder` and  `Decoder` have helpers methods for standard containers and types.

```Swift
import ScaleCodec

struct Test: ScaleCodec.Codable, Equatable {
  let var1: String?
  let var2: BigUInt // will use Compact encoding.
  let var3: [UInt32] // UInt32 will use Compact encoding.
  
  init(_ v1: String?, _ v2: BigUInt, _ v3: [UInt32]) {
    var1 = v1; var2 = v2; var3 = v3
  }
  
  init<D: ScaleCodec.Decoder>(from decoder: inout D) throws {
    var1 = try decoder.decode()
    var2 = try decoder.decode(.compact)
    var3 = try decoder.decode(Array<Compact<UInt32>>.self).map { $0.value }
  }
  
  func encode<E: ScaleCodec.Encoder>(in encoder: inout E) throws {
    try encoder.encode(var1)
    try encoder.encode(var2, .compact)
    try encoder.encode(var3.map { Compact($0) })
  }
}

let val = Test(nil, 123456789, [1, 2, 3, 4, 5])

let data = try encode(val)

let decoded: Test = try decode(from: data)

assert(decoded == val)
```

#### Fixed classes and structures

Classes and structures can be created from fixed encoded `Array` and `Data` object. For convenience ScaleCodec has two sets of protocols: (`FixedEncodable`, `FixedDecodable`) and (`FixedDataEncodable`, `FixedDataDecodable`).

Example:

```Swift
import ScaleCodec

struct StringArray4: Equatable, FixedCodable {
    typealias Element = String // Fixed Array element type
    
    static var fixedElementCount: Int = 4 // amount of elements in Fixed Array
    
    var array: [String]
    
    init(_ array: [String]) {
        self.array = array
    }
    
    init(values: [String]) throws { // decoding from Fixed Array
        self.init(values)
    }
    
    func values() throws -> [String] { // encoding to Fixed Array
        return self.array
    }
}

private struct Data4: Equatable, FixedDataCodable {
    var data: Data
    
    static var fixedBytesCount: Int = 4 // amount of bytes in Fixed Data
    
    init(_ data: Data) {
        self.data = data
    }
    
    init(decoding data: Data) throws { // decoding from Fixed Data
        self.init(data)
    }
    
    func serialize() throws -> Data { // encoding to Fixed Data
        return self.data
    }
}

let string4 = StringArray4(["1", "2", "3", "4"])

let dataS4 = try encode(string4)

let decoded: StringArray4 = try decode(from: dataS4)

assert(decoded == string4)

let data4 = Data4(Data([1, 2, 3, 4]))

let dataE4 = try encode(data4)

let decoded: Data4 = try decode(from: dataE4)

assert(decoded == data4)

```

### Size calculation instead of full parsing
For some cases it is better to calculate size of encoded type, instead of full parsing. In most cases it will be much quicker. For this purposes ScaleCodec has `SizeCalculable` protocol. It implemented for all base types and containers.

```Swift
import ScaleCodec

let data = Data([0x10, 0x04, 0x41, 0x04, 0x42, 0x04, 0x43, 0x0c, 0x44, 0x44, 0x44])
var decoder = decoder(from: data)
var skipDecoder = decoder.skippable() // special decoder which can skip data

let size = try Array<String>.calculateSize(in: &skipDecoder)
assert(size == 11)

let decoded = try decoder.decode(Array<String>.self)
assert(decoded == ["A", "B", "C", "DDD"])
```

## License

ScaleCodec can be used, distributed and modified under [the Apache 2.0 license](LICENSE).
