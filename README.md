# Swift SCALE Codec

![🐧 linux: ready](https://img.shields.io/badge/%F0%9F%90%A7%20linux-ready-red.svg)
[![GitHub license](https://img.shields.io/badge/license-Apache%202.0-lightgrey.svg)](LICENSE)
[![Build Status](https://github.com/tesseract-one/swift-scale-codec/workflows/CI/badge.svg?branch=main)](https://github.com/tesseract-one/swift-scale-codec/actions?query=workflow%3ACI+branch%3Amain)
[![GitHub release](https://img.shields.io/github/release/tesseract-one/swift-scale-codec.svg)](https://github.com/tesseract-one/swift-scale-codec/releases)
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
    .package(url: "https://github.com/tesseract-one/swift-scale-codec.git", from: "0.1.0")
    ```

- **CocoaPods:** Put this in your `Podfile`:

    ```Ruby
    pod 'ScaleCodec', '~> 0.1'
    ```

## Usage Examples

Following are some examples to demonstrate usage of the codec.

### Simple Types

Codec supports `String`, `Bool`, `Int[8-64]`, `UInt[8-64]`,  `BigInt` and  `BigUInt` types. `BigInt` and  `BigUInt` types can store 128 bit integers.

```Swift
import ScaleCodec

let data = Data([0xff, 0xff, 0xff, 0xff])

let encoded = try SCALE.default.encode(UInt32.max)
assert(encoded == data)

let uint32 = try SCALE.default.decode(UInt32.self, from: data)
assert(uint32 == UInt32.max)
```

#### Compact encoding

`UInt[8-64]` and  `BigUInt` types can be encoded with compact encoding. This allows `BigUInt` to store values up to `2^536-1`.

ScaleCodec has special wrapper type `SCompact` which encodes and decodes values in this format and two helper methods.

Example:

```Swift
import ScaleCodec

let data = Data([0x07, 0x00, 0x00, 0x00, 0x00, 0x01]

let encoded = try SCALE.default.encodeCompact(UInt64(1 << 32))
assert(encoded == data))

let compact = try SCALE.default.decodeCompact(UInt64.self, from: data)
assert(compact == UInt64(1 << 32))

// without helper methods
// let encoded = try SCALE.default.encode(SCompact(UInt64(1 << 32)))
// let compact = try SCALE.default.decode(SCompact<UInt64>.self, from: data).value
```

### Container types

ScaleCodec can encode and decode standard containers. Supported containers: `Optional`, `Result`, `Array`, `Set`, `Dictionary`. Containers can be nested in each other. Container element should be encodable.

```Swift
import ScaleCodec

let array: [UInt32] = [1, 2, 3, 4, 5]

let data = try SCALE.default.encode(array)

let decoded: [UInt32] = try SCALE.default.decode(from: data)

assert(array == decoded)
```

### Tuples

Tuple encoding and decoding supported through `STuple*` set of wrappers. ScaleCodec provides `STuple()` helper which can create approptiate `STuple*` instance for a tuple. `STuple*` wrappers can be nested to support bigger tuples. ScaleCodec also has set of helper methods for tuples support. 

```Swift
import ScaleCodec

let tuple = (UInt32.max, "Hello")

let encoded = try SCALE.default.encode(tuple)

let decoded: (UInt32, String) = try SCALE.default.decode(from: encoded)

assert(tuple == decoded.tuple)

// without helper methods
// let encoded = try SCALE.default.encode(STuple(tuple)) // or directly STuple2(tuple)
// let decoded = try SCALE.default.decode(STuple2<UInt32, String>.self, from: encoded).tuple
```

### Enums

#### Simple enums

Simple enums without associated values can be encoded automatically if enum supports `CaseIterable` protocol. Swift has autoimplementation feature for `CaseIterable` protocol for simple enums.

```Swift
import ScaleCodec

enum Test: CaseIterable, ScaleCodable {
  case A
  case B
}

let data = try SCALE.default.encode(Test.A)

let decoded: Test = try SCALE.default.decode(from: data)

assert(decoded == Test.A)
```

#### Complex enums

Encoding and decoding for complex enums with associated values should be implemented manually. Two protocols need to be implemented: `ScaleEncodable` and `ScaleDecodable` (`ScaleCodable` can be used as common alias).

```Swift
import ScaleCodec

enum Test: ScaleCodable {
  case A(String?)
  case B(UInt32, String) // UInt32 will use Compact encoding.
  
  init(from decoder: ScaleDecoder) throws {
    let opt = try decoder.decodeEnumCaseId()
    switch opt {
    case 0: self = try .A(decoder.decode())
    case 1: self = try .B(decoder.decodeCompact(), decoder.decode())
    default: throw decoder.enumCaseError(for: opt)
    }
  }
  
  func encode(in encoder: ScaleEncoder) throws {
    switch self {
    case .A(let str): try encoder.encodeEnumCaseId(0).encode(str)
    case .B(let int, let str): try encoder.encodeEnumCaseId(1).encodeCompact(int).encode(str)
    }
  }
}

let val = Test.B(100, "World!")

let data = try SCALE.default.encode(val)

let decoded: Test = try SCALE.default.decode(from: data)

assert(decoded == val)
```

### Classes and Structures

`ScaleEncodable` and `ScaleDecodable` should be implemented for classes and structures. `ScaleEncoder` and  `ScaleDecoder` has helpers methods for standard containers and types.

```Swift
import ScaleCodec

struct Test: ScaleCodable, Equatable {
  let var1: String?
  let var2: BigUInt // will use Compact encoding.
  let var3: [UInt32] // UInt32 will use Compact encoding.
  
  init(_ v1: String?, _ v2: BigUInt, _ v3: [UInt32]) {
    var1 = v1; var2 = v2; var3 = v3
  }
  
  init(from decoder: ScaleDecoder) throws {
    var1 = try decoder.decode()
    var2 = try decoder.decodeCompact()
    var3 = try decoder.decode(Array<SCompact<UInt32>>.self).map { $0.value }
  }
  
  func encode(in encoder: ScaleEncoder) throws {
    try encoder
      .encode(var1)
      .encodeCompact(var2)
      .encode(var3.map { SCompact($0) })
  }
}

let val = Test(nil, 123456789, [1, 2, 3, 4, 5])

let data = try SCALE.default.encode(val)

let decoded: Test = try SCALE.default.decode(from: data)

assert(decoded == val)
```

## License

ScaleCodec can be used, distributed and modified under [the Apache 2.0 license](LICENSE).
