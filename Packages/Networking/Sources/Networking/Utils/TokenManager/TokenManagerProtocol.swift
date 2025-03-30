//
//  TokenManagerProtocol.swift
//

// MARK: - Token Protocol
public protocol TokenManagerProtocol: AnyObject {
    typealias Tokens = TokenManager.TokensModel

    func updateToken(_ tokens: Tokens?)
}
