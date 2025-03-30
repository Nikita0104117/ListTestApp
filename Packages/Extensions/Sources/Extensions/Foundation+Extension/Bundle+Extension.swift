//
//  Bundle+Extension.swift
//  Extensions

import Foundation

public extension Bundle {
    var isSimulator: Bool {
        guard let path = Bundle.main.appStoreReceiptURL?.path else { return false }

        return path.contains("CoreSimulator")
    }

    var isTestFlight: Bool {
        guard let path = Bundle.main.appStoreReceiptURL?.path else { return false }

        return path.contains("sandboxReceipt")
    }
}
