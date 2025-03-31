//
//  RestClient+Error.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import Networking

// MARK: - RestError
extension RestClient {
    enum RestError: LocalizedError {
        case unknown
        case error(Swift.Error)
        case clientError(message: String)
        case serverError(message: String)
        case decodingError(message: String)

        var errorDescription: String? {
            switch self {
                case .unknown:
                    "Unknown network error occured"
                case .error(let error):
                    error.localizedDescription
                case .clientError(let message):
                    message
                case .serverError(let message):
                    message
                case .decodingError(let message):
                    message
            }
        }

        // MARK: - Init
        init(from requestError: NetworkingSession.RequestError) {
            switch requestError {
                case .unknown:
                    self = .unknown
                case .some(let error):
                    self = .error(error)
                case .clientError(let message, let code):
                    self = .clientError(message: "\(message) (\(code?.rawValue ?? .zero))")
                case .serverError(let message, let code):
                    self = .serverError(message: "\(message) (\(code?.rawValue ?? .zero))")
                case .decodingError(let error):
                    self = .decodingError(message: "DecodingError: \(error.localizedDescription)")
                case .connectionLost:
                    self = .error(requestError)
                case .userCanceledSignInFlow:
                    self = .error(requestError)
                case .requestFailed(let message):
                    self = .clientError(message: message)
                case .requestExplicitlyCancelled:
                    self = .error(requestError)
            }
        }
    }
}
