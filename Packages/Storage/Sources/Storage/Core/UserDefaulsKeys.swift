//
//  UserDefaulsKeys.swift
//  Storage

import Foundation

// MARK: - StoreKeys
public extension UserDefaultsStore {
    enum StoreKeys: String {
        case isFirstLaunch
        case isLoggedIn
        case currentLocalize
        case accentColor
        case vpnProfiles

        case navigationAccentColor
    }
}
