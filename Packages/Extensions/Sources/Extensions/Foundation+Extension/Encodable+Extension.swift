//
//  Encodable+Extension.swift
//  Extensions

import Foundation

public extension Encodable {
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
        else {
            let error: NSError = .init()
            throw error
        }

        return dictionary
    }
}
