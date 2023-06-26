//
//  File.swift
//  
//
//  Created by Yehor Popovych on 10/1/20.
//

import Foundation

public enum EncodingError : Error {
    public struct Context {
        public let path: [String]
        public let debugDescription: String
        
        public init(path: [String], description: String) {
            self.path = path
            self.debugDescription = description
        }
    }
    
    case invalidValue(Any, EncodingError.Context)
}

public enum DecodingError : Error {
    public struct Context {
        public let path: [String]
        public let debugDescription: String
        
        public init(path: [String], description: String) {
            self.path = path
            self.debugDescription = description
        }
    }
    
    /// An indication that a value of the given type could not be decoded because
    /// it did not match the type of what was found in the encoded payload.
    ///
    /// As associated values, this case contains the attempted type and context
    /// for debugging.
    case typeMismatch(Any.Type, DecodingError.Context)

    /// An indication that a non-optional value of the given type was expected,
    /// but a null value was found.
    ///
    /// As associated values, this case contains the attempted type and context
    /// for debugging.
    case valueNotFound(Any.Type, DecodingError.Context)

    /// An indication that the data is corrupted or otherwise invalid.
    ///
    /// As an associated value, this case contains the context for debugging.
    case dataCorrupted(DecodingError.Context)
    
    /// An indication that the amount of data is unsufficient.
    ///
    /// As an associated value, this case contains the context for debugging.
    case notEnoughData(DecodingError.Context)
}


internal struct SContext {
    var currentPath: [String]
    
    init(_ path: [String] = []) {
        self.currentPath = path
    }
    
    mutating func push<T>(elem: T) {
        currentPath.append(String(describing: elem))
    }
    
    mutating func pop() {
        let _ = currentPath.popLast()
    }
}
