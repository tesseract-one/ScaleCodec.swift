#!/usr/bin/env swift

import Foundation

let TAB_SIZE: Int = 4

func tab(_ level: Int) -> String {
    String(repeating: " ", count: level * TAB_SIZE)
}

func struct_name(for size: Int) -> String {
    return "Tuple\(size)"
}

func list(for size: Int, prefix: String, inc: Int, from: Int = 0) -> String {
    return stride(from: from, to: from + size, by: 1)
        .map { "\(prefix)\($0 + inc)" }
        .joined(separator: ", ")
}

func where_list(for size: Int, proto: String, level: Int) -> String {
    guard size > 0 else { return " " }
    return "\n\(tab(level))where\n\(tab(level+1))" +
        stride(from: 0, to: size, by: 4)
            .map { yI in
                stride(from: 0, to: min(size - yI, 4), by: 1)
                    .map { "T\($0+yI+1): \(proto)" }
                    .joined(separator: ", ")
            }
            .joined(separator: ",\n\(tab(level+1))") + "\n"
}

func encode_calls(for size: Int, level: Int) -> String {
    guard size > 0 else { return "" }
    return "\(tab(level))" + stride(from: 0, to: size, by: 3)
        .map { yI in
            stride(from: 0, to: min(size - yI, 3), by: 1)
                .map { "try encoder.encode(_\($0+yI))" }
                .joined(separator: "; ")
        }
        .joined(separator: "\n\(tab(level))")
}

func decode_calls(for size: Int, level: Int) -> String {
    guard size > 0 else { return "" }
    return "\n\(tab(level+1))" + stride(from: 0, to: size, by: 3)
        .map { yI in
            stride(from: 0, to: min(size - yI, 3), by: 1)
                .map { _ in "decoder.decode()" }
                .joined(separator: ", ")
        }
        .joined(separator: ",\n\(tab(level+1))") + "\n\(tab(level))"
}

func sizecalculable_calls(for size: Int, level: Int) -> String {
    guard size > 0 else { return "\(tab(level))0" }
    return "\(tab(level))try " + stride(from: 0, to: size, by: 3)
        .map { yI in
            stride(from: 0, to: min(size - yI, 3), by: 1)
                .map { "T\($0+yI+1).calculateSize(in: &decoder)" }
                .joined(separator: " + ")
        }
        .joined(separator: " +\n\(tab(level))")
}

func storage_vars(for size: Int, level: Int) -> String {
    guard size > 0 else { return "" }
    return "\(tab(level))" + stride(from: 0, to: size, by: 1)
        .map { "public let _\($0): T\($0 + 1)" }
        .joined(separator: "\n\(tab(level))")
}

func init_vars(for size: Int) -> String {
    guard size > 0 else { return "" }
    return stride(from: 0, to: size, by: 1)
        .map { "_ v\($0+1): T\($0+1)" }
        .joined(separator: ", ")
}

func data_init(for size: Int, level: Int) -> String {
    return stride(from: 0, to: size, by: 6)
        .map { yI in
            stride(from: 0, to: min(size - yI, 6), by: 1)
                .map { "_\($0+yI) = v\($0+yI+1)" }
                .joined(separator: "; ")
        }
        .joined(separator: "\n\(tab(level))")
}

func tuple_init_vars(for size: Int, level: Int) -> String {
    guard size > 0 else {
        return "\(tab(level))@inlinable\n\(tab(level))public init() { }"
    }
    return """
    \(tab(level))@inlinable
    \(tab(level))public init(\(init_vars(for: size))) {
    \(tab(level+1))\(data_init(for: size, level: level+1))
    \(tab(level))}
    """
}

func tuple_init_tuple(for size: Int, level: Int) -> String {
    return """
    \(tab(level))@inlinable
    \(tab(level))public init(_ t: STuple) {
    \(tab(level+1))self.init(\(list(for: size, prefix: "t.", inc: 0)))
    \(tab(level))}
    """
}

func tuple_struct(for size: Int, level: Int) -> String {
    let name = struct_name(for: size)
    let types = list(for: size, prefix: "T", inc: 1)
    let type_list = size == 0 ? "" : "<\(types)>"
    return """
    \(tab(level))public struct \(name)\(type_list): ATuple {
    \(tab(level+1))public typealias STuple = (\(types))
    \(storage_vars(for: size, level: level+1))
    \(tuple_init_vars(for: size, level: level+1))
    \(size == 1 ? "" : tuple_init_tuple(for: size, level: level+1))
    \(tab(level+1))@inlinable
    \(tab(level+1))public var tuple: STuple {
    \(tab(level+2))(\(list(for: size, prefix: "_", inc: 0)))
    \(tab(level+1))}
    \(tab(level+1))@inlinable
    \(tab(level+1))public static var count: Int { \(size) }
    \(tab(level))}
    """
}

func tuple_linked(for size: Int, level: Int) -> String {
    guard size > 0 else { return "" }
    let name = struct_name(for: size)
    let prev_name = struct_name(for: size-1)
    let drop_first_types = size == 1 ? "" : "<\(list(for: size-1, prefix: "T", inc: 1, from: 1))>"
    let drop_last_types = size == 1 ? "" : "<\(list(for: size-1, prefix: "T", inc: 1, from: 0))>"
    let init_first = size == 1 ? "" : "\(list(for: size-1, prefix: "first._", inc: 0)), "
    let init_last = size == 1 ? "" : ", \(list(for: size-1, prefix: "last._", inc: 0))"
    return """
    \(tab(level))extension \(name): LinkedTuple {
    \(tab(level+1))public typealias First = T1
    \(tab(level+1))public typealias Last = T\(size)
    \(tab(level+1))public typealias DroppedFirst = \(prev_name)\(drop_first_types)
    \(tab(level+1))public typealias DroppedLast = \(prev_name)\(drop_last_types)
    \(tab(level+1))@inlinable
    \(tab(level+1))public init(first: DroppedLast, last: Last) {
    \(tab(level+2))self.init(\(init_first)last)
    \(tab(level+1))}
    \(tab(level+1))@inlinable
    \(tab(level+1))public init(first: First, last: DroppedFirst) {
    \(tab(level+2))self.init(first\(init_last))
    \(tab(level+1))}
    \(tab(level+1))public var first: First { _0 }
    \(tab(level+1))public var last: Last { _\(size-1) }
    \(tab(level+1))public var dropLast: DroppedLast {
    \(tab(level+2))\(prev_name)(\((list(for: size-1, prefix: "_", inc: 0))))
    \(tab(level+1))}
    \(tab(level+1))public var dropFirst: DroppedFirst {
    \(tab(level+2))\(prev_name)(\((list(for: size-1, prefix: "_", inc: 0, from: 1))))
    \(tab(level+1))}
    \(tab(level))}
    """
}

func tuple_constructor_func(for size: Int, level: Int) -> String {
    let name = struct_name(for: size)
    let types = list(for: size, prefix: "T", inc: 1)
    let type_list = size == 0 ? "" : "<\(types)>"
    return """
    \(tab(level))public func Tuple\(type_list)(_ t: (\(types))) -> \(name)\(type_list) {
    \(tab(level+1))\(name)(t)
    \(tab(level))}
    """
}

func tuple_encodable_decodable(for size: Int, level: Int) -> String {
    let name = struct_name(for: size)
    let where_enc = where_list(for: size, proto: "Encodable", level: level+1)
    let where_dec = where_list(for: size, proto: "Decodable", level: level+1)
    return """
    \(tab(level))extension \(name): Encodable\(where_enc){
    \(tab(level+1))public func encode<E: Encoder>(in encoder: inout E) throws {
    \(size <= 0 ? "" : "\(encode_calls(for: size, level: level+2))")
    \(tab(level+1))}
    \(tab(level))}
    \(tab(level))extension \(name): Decodable\(where_dec){
    \(tab(level+1))public init<D: Decoder>(from decoder: inout D) throws {
    \(tab(level+2))\(size > 0 ? "try " : "")self.init(\(decode_calls(for: size, level: level+2)))
    \(tab(level+1))}
    \(tab(level))}
    """
}

func tuple_sizecalculable(for size: Int, level: Int) -> String {
    let name = struct_name(for: size)
    let where_clc = where_list(for: size, proto: "SizeCalculable", level: level+1)
    return """
    \(tab(level))extension \(name): SizeCalculable\(where_clc){
    \(tab(level+1))public static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
    \(sizecalculable_calls(for: size, level: level+2))
    \(tab(level+1))}
    \(tab(level))}
    """
}

func tuple_encoder_and_decoder_helpers(for size: Int, level: Int) -> String {
    guard size >= 0, size != 1 else { return "" }
    let name = struct_name(for: size)
    let types = list(for: size, prefix: "T", inc: 1)
    let type_list = size == 0 ? "" : "<\(types)>"
    let where_enc = size == 0 ? " " : where_list(for: size, proto: "Encodable", level: level+1) + tab(level)
    let where_enc_l2 = size == 0 ? " " : where_list(for: size, proto: "Encodable", level: level+2) + tab(level+1)
    let where_dec = size == 0 ? " " : where_list(for: size, proto: "Decodable", level: level+1) + tab(level)
    let where_dec_l2 = size == 0 ? " " : where_list(for: size, proto: "Decodable", level: level+2) + tab(level+1)
    return """
    \(tab(level))public extension Decoder {
    \(tab(level+1))mutating func decode\(type_list)(_ t: (\(types)).Type) throws -> (\(types))\(where_dec_l2){
    \(tab(level+2))try self.decode(\(name)\(type_list).self).tuple
    \(tab(level+1))}
    \(tab(level+1))mutating func decode\(type_list)() throws -> (\(types))\(where_dec_l2){
    \(tab(level+2))try self.decode(\(name)\(type_list).self).tuple
    \(tab(level+1))}
    \(tab(level))}
    \(tab(level))public extension Encoder {
    \(tab(level+1))mutating func encode\(type_list)(_ value: (\(types))) throws\(where_enc_l2){
    \(tab(level+2))try self.encode(\(name)(value))
    \(tab(level+1))}
    \(tab(level))}
    \(tab(level))public func encode\(type_list)(_ value: (\(types)), reservedCapacity: Int = 4096) throws -> Data\(where_enc){
    \(tab(level+1))try encode(\(name)(value), reservedCapacity: reservedCapacity)
    \(tab(level))}
    \(tab(level))public func decode\(type_list)(_ t: (\(types)).Type, from data: Data) throws -> (\(types))\(where_dec){
    \(tab(level+1))try decode(from: data)
    \(tab(level))}
    \(tab(level))public func decode\(type_list)(from data: Data) throws -> (\(types))\(where_dec){
    \(tab(level+1))try decode(\(name)\(type_list).self, from: data).tuple
    \(tab(level))}
    """
}

func tuple(for size: Int) -> String {
    let name = struct_name(for: size)
    var result = "//================ \(name) ==================\n"
    result += tuple_struct(for: size, level: 0)
    if (size > 0) {
        result += "\n" + tuple_linked(for: size, level: 0)
    }
    result += "\n" + tuple_constructor_func(for: size, level: 0)
    result += "\n" + tuple_encodable_decodable(for: size, level: 0)
    result += "\n" + tuple_sizecalculable(for: size, level: 0)
    result += "\n" + tuple_encoder_and_decoder_helpers(for: size, level: 0)
    result += "\n//============== end of \(name) ============="
    return result
}

// MAIN
let strFrom = CommandLine.arguments.count > 1 ? CommandLine.arguments[1] : "1"
let strTo = CommandLine.arguments.count > 2 ? CommandLine.arguments[2] : strFrom
let from = Int(strFrom)!
let to = Int(strTo)!
let name = CommandLine.arguments[0].split(separator: "/").last!.split(separator: "\\").last!
print("//\n// Generated '\(Date())' with '\(name)'\n//")
print("import Foundation")
for i in from...to {
    print("\n", tuple(for: i), separator: "")
}
