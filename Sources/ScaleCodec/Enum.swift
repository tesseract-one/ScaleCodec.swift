//
//  Enum.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension CaseIterable where Self: Equatable & Encodable, Self.AllCases.Index == Int {
    public func encode<E: Encoder>(in encoder: inout E) throws {
        let caseId = Self.allCases.firstIndex(of: self)! // It's safe.
        try encoder.encode(UInt8(caseId), .enumCaseId)
    }
}

extension CaseIterable where Self: Equatable & Decodable, Self.AllCases.Index == Int {
    public init<D: Decoder>(from decoder: inout D) throws {
        let caseId = try decoder.decode(.enumCaseId)
        guard caseId < Self.allCases.count else {
            throw decoder.enumCaseError(for: caseId)
        }
        self = Self.allCases[Int(caseId)]
    }
}

public extension CaseIterable {
    static func calculateSize<D: SkippableDecoder>(in decoder: inout D) throws -> Int {
        try decoder.skip(count: 1)
        return 1
    }
}

extension CustomDecoderFactory where T == UInt8 {
    public static var enumCaseId: CustomDecoderFactory {
        CustomDecoderFactory { try $0.decode() }
    }
}

extension CustomEncoderFactory where T == UInt8 {
    public static var enumCaseId: CustomEncoderFactory {
        CustomEncoderFactory { try $0.encode($1) }
    }
}

extension Decoder {
    public func enumCaseError(for index: UInt8) -> DecodingError {
        return DecodingError.dataCorrupted(
            DecodingError.Context(
                path: self.path,
                description: "Wrong case index: \(index)"
            )
        )
    }
}
