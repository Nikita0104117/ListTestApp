//
//  Dictionary+Extension.swift
//  Extensions


import Foundation

public extension Dictionary {
    subscript (safe key: Key) -> Value? {
        index(forKey: key) == nil ? nil : self[key]
    }
}
