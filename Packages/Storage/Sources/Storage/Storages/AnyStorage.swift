//
//  AnyStorage.swift
//  Storage

import Foundation

public class AnyStorage<State: StoreProtocol>: StoreProtocol {
    public typealias Keys = State.Keys

    private let state: State

    public init(state: State) {
        self.state = state
    }

    public func get<T>(_ key: State.Keys) -> T? where T: Decodable {
        state.get(key)
    }

    public func get<T>(_ key: State.Keys) -> [T] where T: Decodable {
        state.get(key)
    }

    public func set<T>(_ value: T?, key: State.Keys) where T: Encodable {
        state.set(value, key: key)
    }

    public func remove(key: State.Keys) {
        state.remove(key: key)
    }

    public func clear() {
        state.clear()
    }
}
