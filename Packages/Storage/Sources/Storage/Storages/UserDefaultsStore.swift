//
//  UserDefaultsStore.swift
//  Storage

import Foundation
import Utility

// MARK: - UserDefaultsStoreKeys
public enum UserDefaultsStoreKeys {
    public static let appGroupUserDefaultsStore = "group.ListApp.bundle"
}

// MARK: - UserDefaultsStore
public final class UserDefaultsStore: StoreProtocol {
    public typealias Keys = StoreKeys

    private let userDefaults: UserDefaults
    private let persistentDomainName: String

    public init(userDefaults: UserDefaults) {
        self.userDefaults = userDefaults
        self.persistentDomainName = Bundle.main.bundleIdentifier ?? ""
    }

    public init(suiteName: String) {
        guard
            let userDefaults: UserDefaults = .init(suiteName: UserDefaultsStoreKeys.appGroupUserDefaultsStore)
        else {
            log.error("Error: missed suiteName key for UserDefaults initialization")
            preconditionFailure()
        }

        self.userDefaults = userDefaults
        self.persistentDomainName = UserDefaultsStoreKeys.appGroupUserDefaultsStore
    }

    public func get<T>(_ key: StoreKeys) -> T? where T: Decodable {
        do {
            guard let data = userDefaults.object(forKey: key.rawValue) as? Data else { return nil }

            return try JSONDecoder().decode(T.self, from: data)
        } catch let error {
            log.error("error: \(error.localizedDescription)")
            return nil
        }
    }

    public func get<T>(_ key: StoreKeys) -> [T] where T: Decodable {
        do {
            guard let data = userDefaults.object(forKey: key.rawValue) as? Data else { return [] }

            return try JSONDecoder().decode([T].self, from: data)
        } catch let error {
            log.error("error: \(error.localizedDescription)")
            return []
        }
    }

    public func set<T>(_ value: T?, key: StoreKeys) where T: Encodable {
        guard let value = value else {
            userDefaults.set(nil, forKey: key.rawValue)
            return
        }

        do {
            let data = try JSONEncoder().encode(value)
            userDefaults.set(data, forKey: key.rawValue)
        } catch let error {
            log.error("error: \(error.localizedDescription)")
        }
    }

    public func remove(key: StoreKeys) {
        userDefaults.removeObject(forKey: key.rawValue)
    }

    public func clear() {
        userDefaults.removePersistentDomain(forName: persistentDomainName)
        userDefaults.synchronize()
    }
}
