//
//  StoreProtocol.swift
//  Storage

public protocol StoreProtocol: AnyObject {
    associatedtype Keys

    func get<T: Decodable>(_ key: Keys) -> T?
    func get<T: Decodable>(_ key: Keys) -> [T]
    func set<T: Encodable>(_ value: T?, key: Keys)
    func remove(key: Keys)
    func clear()
}
