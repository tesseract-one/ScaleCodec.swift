//
//  Array.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension Array: ContainerEncodable {
    public typealias EElement = Element
    
    public func encode<E: Encoder>(in encoder: inout E, writer: @escaping (EElement, inout E) throws -> Void) throws {
        try encoder.encode(UInt32(count), .compact)
        for element in self {
            try writer(element, &encoder)
        }
    }
}

extension Array: ContainerDecodable {
    public typealias DElement = Element
    
    public init<D: Decoder>(from decoder: inout D, reader: @escaping (inout D) throws -> Element) throws {
        let size = try Int(decoder.decode(UInt32.self, .compact))
        var array = Array<Element>()
        array.reserveCapacity(size)
        for _ in 0..<size {
            try array.append(reader(&decoder))
        }
        self = array
    }
}

extension Array: Encodable where Element: Encodable {}

extension Array: Decodable where Element: Decodable {}

public protocol ArrayInitializable {
    associatedtype IElement
    
    init(array: [IElement])
}

extension Array: ArrayInitializable {
    public typealias IElement = Element
    
    public init(array: [IElement]) {
        self.init(array)
    }
}

public protocol ArrayConvertible {
    associatedtype CElement
    
    var asArray: [CElement] { get }
}

extension Array: ArrayConvertible {
    public typealias CElement = Element
    
    public var asArray: [CElement] { return self }
}

extension CustomDecoderFactory where T: ArrayInitializable, T.IElement: Decodable {
    public static func fixed(_ size: UInt) -> CustomDecoderFactory {
        .fixed(size) { decoder in try decoder.decode() }
    }
}

extension CustomDecoderFactory where T: ArrayInitializable {
    public static func fixed(
        _ size: UInt, _ reader: @escaping (inout D) throws -> T.IElement
    ) -> CustomDecoderFactory {
        CustomDecoderFactory { decoder in
            var values = Array<T.IElement>()
            values.reserveCapacity(Int(size))
            for _ in 0..<size {
                try values.append(reader(&decoder))
            }
            return T(array: values)
        }
    }
}

extension CustomEncoderFactory where T: ArrayConvertible {
    public static func fixed(
        _ size: UInt, writer: @escaping (T.CElement, inout E) throws -> Void
    ) -> CustomEncoderFactory {
        CustomEncoderFactory { encoder, conv in
            let values = conv.asArray
            guard values.count == size else {
                throw EncodingError.invalidValue(
                    values, EncodingError.Context(
                        path: encoder.path,
                        description: "Wrong value count \(values.count) expected \(size)"
                    )
                )
            }
            for val in values {
                try writer(val, &encoder)
            }
        }
    }
}

extension CustomEncoderFactory where T: ArrayConvertible, T.CElement: Encodable {
    public static func fixed(_ size: UInt) -> CustomEncoderFactory {
        .fixed(size) { val, enc in try enc.encode(val) }
    }
}

extension Array: ContainerSizeCalculable {
    public typealias SElement = Element
    
    public static func calculateSize<D: SkippableDecoder>(
        in decoder: inout D,
        esize: @escaping (inout D) throws -> Int
    ) throws -> Int {
        let cSize = try Compact<UInt32>.calculateSizeNoSkip(in: &decoder)
        let size = try Int(decoder.decode(UInt32.self, .compact))
        return try (0..<size).reduce(cSize) { (sum, _) in
            try sum + esize(&decoder)
        }
    }
}

extension Array: SizeCalculable where Element: SizeCalculable {}
