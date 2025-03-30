//
//  Date+Extension.swift
//

import Foundation

public extension Date {
    static func - (lhs: Date, rhs: Date) -> Date {
        .init(timeIntervalSinceReferenceDate: lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate)
    }
}
