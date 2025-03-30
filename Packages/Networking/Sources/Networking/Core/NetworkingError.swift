//
//  NetworkingError.swift
//

import Foundation

// MARK: - NetworkingError
public enum NetworkingError: Error {
    case customError(String)
}

extension NetworkingError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .customError(let string):
                return string
        }
    }
}

// MARK: - ServerError
public typealias ServerError = Decodable & Error

// MARK: - ErrorObject
public struct RawError: ServerError {
    public let message: String
}
