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
        try encoder.encodeEnumCaseId(UInt8(caseId))
    }
}

extension CaseIterable where Self: Equatable & ScaleDecodable, Self.AllCases.Index == Int {
    public init(from decoder: ScaleDecoder) throws {
        let caseId = try decoder.decodeEnumCaseId()
        guard caseId < Self.allCases.count else {
            throw decoder.enumCaseError(for: caseId)
        }
        self = Self.allCases[Int(caseId)]
    }
}


extension ScaleDecoder {
    public func decodeEnumCaseId() throws -> UInt8 {
        return try self.decode()
    }
    
    public func enumCaseError(for index: UInt8) -> SDecodingError {
        return SDecodingError.dataCorrupted(
            SDecodingError.Context(
                path: self.path,
                description: "Wrong case index: \(index)"
            )
        )
    }
}

extension ScaleEncoder {
    @discardableResult
    public func encodeEnumCaseId(_ id: UInt8) throws -> ScaleEncoder {
        return try self.encode(id)
    }
}
