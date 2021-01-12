//
//  Enum.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

extension CaseIterable where Self: Equatable & ScaleEncodable, Self.AllCases.Index == Int {
    public func encode(in encoder: ScaleEncoder) throws {
        let caseId = Self.allCases.firstIndex(of: self)! // It's safe.
        try encoder.encode(UInt8(caseId), .enumCaseId)
    }
}

extension CaseIterable where Self: Equatable & ScaleDecodable, Self.AllCases.Index == Int {
    public init(from decoder: ScaleDecoder) throws {
        let caseId = try decoder.decode(.enumCaseId)
        guard caseId < Self.allCases.count else {
            throw decoder.enumCaseError(for: caseId)
        }
        self = Self.allCases[Int(caseId)]
    }
}

extension ScaleCustomDecoderFactory where T == UInt8 {
    public static var enumCaseId: ScaleCustomDecoderFactory {
        ScaleCustomDecoderFactory { try $0.decode() }
    }
}

extension ScaleCustomEncoderFactory where T == UInt8 {
    public static var enumCaseId: ScaleCustomEncoderFactory {
        ScaleCustomEncoderFactory { try $0.encode($1) }
    }
}

extension ScaleDecoder {
    public func enumCaseError(for index: UInt8) -> SDecodingError {
        return SDecodingError.dataCorrupted(
            SDecodingError.Context(
                path: self.path,
                description: "Wrong case index: \(index)"
            )
        )
    }
}
