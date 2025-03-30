//
//  AnyNetworkService.swift
//

/// Uses to build concrete service entity.
public protocol AnyNetworkService {
    var restClient: NetworkingSessionProtocol { get }
}
