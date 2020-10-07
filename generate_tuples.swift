#!/usr/bin/env swift

import Foundation

let TAB_SIZE: Int = 4

func generate_struct_name(for size: Int) -> String {
    return "STuple\(size)"
}

func generate_list(for size: Int, prefix: String, inc: Int) -> String {
    return stride(from: 0, to: size, by: 1)
        .map { "\(prefix)\($0 + inc)" }
        .joined(separator: ", ")
}

func generate_where_type_list(for size: Int, proto: String, tab: Int) -> String {
    let prefix = String(repeating: " ", count: tab * TAB_SIZE)
    return stride(from: 0, to: size, by: 4)
        .map { yI in
            stride(from: 0, to: min(size - yI, 4), by: 1)
                .map { "T\($0+yI+1): \(proto)" }
                .joined(separator: ", ")
        }
        .joined(separator: ",\n" + prefix)
}

func generate_encode_calls(for size: Int, tab: Int) -> String {
    let prefix = String(repeating: " ", count: tab * TAB_SIZE)
    return stride(from: 0, to: size, by: 5)
        .map { yI in
            "." + stride(from: 0, to: min(size - yI, 5), by: 1)
                .map { "encode(_\($0+yI))" }
                .joined(separator: ".")
        }
        .joined(separator: "\n" + prefix)
}

func generate_decode_calls(for size: Int, tab: Int) -> String {
    let prefix = String(repeating: " ", count: tab * TAB_SIZE)
    return stride(from: 0, to: size, by: 3)
        .map { yI in
            stride(from: 0, to: min(size - yI, 3), by: 1)
                .map { _ in "decoder.decode()" }
                .joined(separator: ", ")
        }
        .joined(separator: ",\n" + prefix)
}

func generate_storage_vars(for size: Int, tab: Int) -> String {
    let prefix = String(repeating: " ", count: tab * TAB_SIZE)
    return stride(from: 0, to: size, by: 1)
        .map { "public let _\($0): T\($0 + 1)" }
        .joined(separator: "\n" + prefix)
}

func generate_init_vars(for size: Int) -> String {
    return stride(from: 0, to: size, by: 1)
        .map { "_ v\($0+1): T\($0+1)" }
        .joined(separator: ", ")
}

func generate_data_init(for size: Int, tab: Int) -> String {
    let prefix = String(repeating: " ", count: tab * TAB_SIZE)
    return stride(from: 0, to: size, by: 6)
        .map { yI in
            stride(from: 0, to: min(size - yI, 6), by: 1)
                .map { "_\($0+yI) = v\($0+yI+1)" }
                .joined(separator: "; ")
        }
        .joined(separator: "\n" + prefix)
}

func generate_tuple(for size: Int) -> String {
    let name = generate_struct_name(for: size)
    let types = generate_list(for: size, prefix: "T", inc: 1)
    return """
    public struct \(name)<\(types)> {
        \(generate_storage_vars(for: size, tab: 1))

        public init(\(generate_init_vars(for: size))) {
            \(generate_data_init(for: size, tab: 2))
        }

        public init(_ t: (\(types))) {
            self.init(\(generate_list(for: size, prefix: "t.", inc: 0)))
        }

        public var tuple: (\(types)) {
            return (\(generate_list(for: size, prefix: "_", inc: 0)))
        }
    }

    public func STuple<\(types)>(_ t: (\(types))) -> \(name)<\(types)> {
        return \(name)(t)
    }

    extension \(name): ScaleEncodable
        where
            \(generate_where_type_list(for: size, proto: "ScaleEncodable", tab: 2))
    {
        public func encode(in encoder: ScaleEncoder) throws {
            try encoder
                \(generate_encode_calls(for: size, tab: 3))
        }
    }

    extension \(name): ScaleDecodable
        where
            \(generate_where_type_list(for: size, proto: "ScaleDecodable", tab: 2))
    {
        public init(from decoder: ScaleDecoder) throws {
            try self.init(
                \(generate_decode_calls(for: size, tab: 3))
            )
        }
    }

    extension ScaleDecoder {
        public func decode<\(types)>(_ t: (\(types)).Type) throws -> (\(types))
            where
                \(generate_where_type_list(for: size, proto: "ScaleDecodable", tab: 3))
        {
            return try self.decode(\(name)<\(types)>.self).tuple
        }

        public func decode<\(types)>() throws -> (\(types))
            where
                \(generate_where_type_list(for: size, proto: "ScaleDecodable", tab: 3))
        {
            return try self.decode(\(name)<\(types)>.self).tuple
        }
    }

    extension ScaleEncoder {
        @discardableResult
        public func encode<\(types)>(_ value: (\(types))) throws -> ScaleEncoder
            where
                \(generate_where_type_list(for: size, proto: "ScaleEncodable", tab: 3))
        {
            try self.encode(STuple(value))
        }
    }

    extension SCALE {
        public func encode<\(types)>(_ value: (\(types))) throws -> Data
            where
                \(generate_where_type_list(for: size, proto: "ScaleEncodable", tab: 3))
        {
            return try self.encode(STuple(value))
        }

        public func decode<\(types)>(_ t: (\(types)).Type, from data: Data) throws -> (\(types))
            where
                \(generate_where_type_list(for: size, proto: "ScaleDecodable", tab: 3))
        {
            return try self.decode(from: data)
        }

        public func decode<\(types)>(from data: Data) throws -> (\(types))
            where
                \(generate_where_type_list(for: size, proto: "ScaleDecodable", tab: 3))
        {
            return try self.decode(\(name)<\(types)>.self, from: data).tuple
        }
    }
    """
}

// MAIN
let strFrom = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "2"
let strTo = CommandLine.arguments.count > 2 ? CommandLine.arguments[2] : strFrom
let from = Int(strFrom)!
let to = Int(strTo)!
let name = CommandLine.arguments[0].split(separator: "/").last!.split(separator: "\\").last!
print("//\n// Generated '\(Date())' with '\(name)'\n//")
print("import Foundation")
for i in from...to {
    print("\n", generate_tuple(for: i))
}
