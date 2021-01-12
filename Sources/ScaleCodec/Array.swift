//
//  Array.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension Array: ScaleContainerEncodable {
    public typealias EElement = Element
    
    public func encode(in encoder: ScaleEncoder, writer: @escaping (EElement, ScaleEncoder) throws -> Void) throws {
        try encoder.encode(UInt32(count), .compact)
        for element in self {
            try writer(element, encoder)
        }
    }
}

extension Array: ScaleContainerDecodable {
    public typealias DElement = Element
    
    public init(from decoder: ScaleDecoder, reader: @escaping (ScaleDecoder) throws -> Element) throws {
        let size = try Int(decoder.decode(UInt32.self, .compact))
        var array = Array<Element>()
        array.reserveCapacity(size)
        for _ in 0..<size {
            try array.append(reader(decoder))
        }
        self = array
    }
}

extension Array: ScaleEncodable where Element: ScaleEncodable {}

extension Array: ScaleDecodable where Element: ScaleDecodable {}

public protocol ScaleArrayInitializable {
    associatedtype IElement
    
    init(array: [IElement])
}

extension Array: ScaleArrayInitializable {
    public typealias IElement = Element
    
    public init(array: [IElement]) {
        self.init(array)
    }
}

public protocol ScaleArrayConvertible {
    associatedtype CElement
    
    var asArray: [CElement] { get }
}

extension Array: ScaleArrayConvertible {
    public typealias CElement = Element
    
    public var asArray: [CElement] { return self }
}

extension ScaleCustomDecoderFactory where T: ScaleArrayInitializable, T.IElement: ScaleDecodable {
    public static func fixed(_ size: UInt) -> ScaleCustomDecoderFactory {
        .fixed(size) { decoder in try decoder.decode() }
    }
}

extension ScaleCustomDecoderFactory where T: ScaleArrayInitializable {
    public static func fixed(
        _ size: UInt, _ reader: @escaping (ScaleDecoder) throws -> T.IElement
    ) -> ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { decoder in
            var values = Array<T.IElement>()
            values.reserveCapacity(Int(size))
            for _ in 0..<size {
                try values.append(reader(decoder))
            }
            return T(array: values)
        }
    }
}

extension ScaleCustomEncoderFactory where T: ScaleArrayConvertible {
    public static func fixed(
        _ size: UInt, writer: @escaping (T.CElement, ScaleEncoder) throws -> Void
    ) -> ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { encoder, conv in
            let values = conv.asArray
            guard values.count == size else {
                throw SEncodingError.invalidValue(
                    values, SEncodingError.Context(
                        path: encoder.path,
                        description: "Wrong value count \(values.count) expected \(size)"
                    )
                )
            }
            for val in values {
                try writer(val, encoder)
            }
            return encoder
        }
    }
}

extension ScaleCustomEncoderFactory where T: ScaleArrayConvertible, T.CElement: ScaleEncodable {
    public static func fixed(_ size: UInt) -> ScaleCustomEncoderFactory {
        .fixed(size) { val, enc in try enc.encode(val) }
    }
}
