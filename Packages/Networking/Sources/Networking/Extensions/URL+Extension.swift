//
//  URL+Extension.swift
//

import Foundation

public extension URL {
    var fileSize: Double {
        var fileSize: Double = 0.0
        var fileSizeValue = 0.0
        try? fileSizeValue = (self.resourceValues(forKeys: [URLResourceKey.fileSizeKey]).allValues.first?.value as? Double) ?? .zero
        if fileSizeValue > 0.0 {
            fileSize = Double(fileSizeValue)
        }
        return fileSize
    }
}
