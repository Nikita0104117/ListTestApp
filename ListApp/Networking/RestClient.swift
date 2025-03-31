//
//  RestClient.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import Networking

// MARK: - BasePath
enum BasePath {
    static let baseApiUrl: String = "https://rickandmortyapi.com"
}

// MARK: - ApiURLsPath
enum ApiURLsPath {
    static let baseUrl: String = "\(BasePath.baseApiUrl)/api"
}

struct VoidDecodable: Decodable { }

// MARK: - RestClient
final class RestClient: NetworkingSession {
    override init(baseURL: String = "", connectivity: Connectivity) {
        super.init(baseURL: baseURL, connectivity: connectivity)

        self.interceptorDelegate = self
    }
}

// MARK: - InterceptorDelegate
extension RestClient: InterceptorDelegate {
    func retry(_ request: Request, dueTo error: Error, completion: @escaping (RetryResult) -> Void) {
        completion(.doNotRetry)
    }
}

// MARK: - ResponseModels
enum ResponseModels { }

// MARK: - RequestModels
enum RequestModels { }
