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
            .joined(separator: ",\n\(tab(level+1))")
}

func tuple_encodable_decodable(for size: Int, level: Int) -> String {
    let name = struct_name(for: size)
    let where_enc = where_list(for: size, proto: "Encodable", level: level+1)
    let where_dec = where_list(for: size, proto: "Decodable", level: level+1)
    return """
    \(tab(level))extension \(name): Decodable\(where_dec) {}
    \(tab(level))extension \(name): Encodable\(where_enc) {}
    """
}

func tuple_sizecalculable(for size: Int, level: Int) -> String {
    let name = struct_name(for: size)
    let where_clc = where_list(for: size, proto: "SizeCalculable", level: level+1)
    return "\(tab(level))extension \(name): SizeCalculable\(where_clc) {}"
}

func tuple_encoder_and_decoder_helpers(for size: Int, level: Int) -> String {
    guard size >= 0, size != 1 else { return "" }
    let name = size == 0 ? "VoidTuple" : struct_name(for: size)
    let types = list(for: size, prefix: "T", inc: 1)
    let type_list = size == 0 ? "" : "<\(types)>"
    let where_enc = size == 0
        ? " "
        : "\(where_list(for: size, proto: "Encodable", level: level+1))\n\(tab(level))"
    let where_enc_l2 = size == 0
        ? " "
        : "\(where_list(for: size, proto: "Encodable", level: level+2))\n\(tab(level+1))"
    let where_dec = size == 0
        ? " "
        : "\(where_list(for: size, proto: "Decodable", level: level+1))\n\(tab(level))"
    let where_dec_l2 = size == 0
        ? " "
        : "\(where_list(for: size, proto: "Decodable", level: level+2))\n\(tab(level+1))"
    return """
    \(tab(level))public extension Decoder {
    \(tab(level+1))@inlinable
    \(tab(level+1))mutating func decode\(type_list)(_ t: (\(types)).Type) throws -> (\(types))\(where_dec_l2){
    \(tab(level+2))try self.decode(\(name)\(type_list).self).tuple
    \(tab(level+1))}
    \(tab(level+1))@inlinable
    \(tab(level+1))mutating func decode\(type_list)() throws -> (\(types))\(where_dec_l2){
    \(tab(level+2))try self.decode(\(name)\(type_list).self).tuple
    \(tab(level+1))}
    \(tab(level))}
    \(tab(level))public extension Encoder {
    \(tab(level+1))@inlinable
    \(tab(level+1))mutating func encode\(type_list)(_ value: (\(types))) throws\(where_enc_l2){
    \(tab(level+2))try self.encode(\(name)(value))
    \(tab(level+1))}
    \(tab(level))}
    \(tab(level))@inlinable
    \(tab(level))public func encode\(type_list)(
    \(tab(level+1))_ value: (\(types)),
    \(tab(level+1))reservedCapacity: Int = SCALE_CODEC_DEFAULT_ENCODER_CAPACITY
    \(tab(level))) throws -> Data\(where_enc){
    \(tab(level+1))try encode(\(name)(value), reservedCapacity: reservedCapacity)
    \(tab(level))}
    \(tab(level))@inlinable
    \(tab(level))public func decode\(type_list)(_ t: (\(types)).Type, from data: Data) throws -> (\(types))\(where_dec){
    \(tab(level+1))try decode(from: data)
    \(tab(level))}
    \(tab(level))@inlinable
    \(tab(level))public func decode\(type_list)(from data: Data) throws -> (\(types))\(where_dec){
    \(tab(level+1))try decode(\(name)\(type_list).self, from: data).tuple
    \(tab(level))}
    """
}

func tuple(for size: Int) -> String {
    let name = struct_name(for: size)
    var result = "//================ \(name) ==================\n"
    result += tuple_encodable_decodable(for: size, level: 0)
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
print("@_exported import Tuples")
for i in from...to {
    print("\n", tuple(for: i), separator: "")
}
