//
//  KeychainStore.swift
//  Storage

import Foundation
import KeychainAccess
import Utility

public final class KeychainStore: StoreProtocol {
    public typealias Keys = StoreKeys

    public init() {}

    private let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "")

    public func get<T>(_ key: StoreKeys) -> T? where T: Decodable {
        do {
            guard let data = try keychain.getData(key.rawValue) else { return nil }

            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            log.error("‼️ Error get value 🔑: \(error.localizedDescription)")
            return nil
        }
    }

    public func get<T>(_ key: Keys) -> [T] where T: Decodable {
        do {
            guard let data = try keychain.getData(key.rawValue) else { return [] }

            return try JSONDecoder().decode([T].self, from: data)
        } catch let error {
            log.error("🔑 error: \(error.localizedDescription)")
            return []
        }
    }

    public func set<T>(_ value: T?, key: StoreKeys) where T: Encodable {
        guard let value = value else { return }

        do {
            let data = try JSONEncoder().encode(value)

            try keychain.set(data, key: key.rawValue)
        } catch let error {
            log.error("‼️ Error set to 🔑: \(error.localizedDescription)")
        }
    }

    public func remove(key: StoreKeys) {
        do {
            try keychain.remove(key.rawValue)
        } catch let error {
            log.error("‼️ Error remove from 🔑: \(error.localizedDescription)")
        }
    }

    public func clear() {
        do {
            try keychain.removeAll()
        } catch let error {
            log.error("‼️ Error remove all 🔑: \(error.localizedDescription)")
        }
    }
}
