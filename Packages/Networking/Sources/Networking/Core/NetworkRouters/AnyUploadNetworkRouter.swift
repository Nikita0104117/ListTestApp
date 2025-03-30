//
//  AnyUploadNetworkRouter.swift
//

import Foundation
import Alamofire

// MARK: - Upload File Router Protocol
public protocol AnyUploadNetworkRouter {
    typealias Endpoint = String

    var fileURL: URL { get }
    var fileName: String { get }
    var fileType: String { get }
    var mimeType: String { get }

    var path: Endpoint { get }
    var method: HTTPMethod { get }
    var headers: HTTPHeaders? { get }
    var addAuth: Bool { get }
}

public extension AnyUploadNetworkRouter {
    var method: HTTPMethod { .post }
    var headers: HTTPHeaders? { ["Accept": "application/json"] }
    var addAuth: Bool { false }
}
