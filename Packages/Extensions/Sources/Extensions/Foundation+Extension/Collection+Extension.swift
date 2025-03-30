//
//  Collection+Extension.swift
//  Extensions

import Foundation

public extension Collection {
    subscript (safe index: Index) -> Element? {
        indices.contains(index) ? self[index] : nil
    }
}
