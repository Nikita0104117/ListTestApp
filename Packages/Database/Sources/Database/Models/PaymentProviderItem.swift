//
//  PaymentProviderItem.swift
//  BelotPay
//
//  Created by Vyacheslav Razumeenko on 26.09.2024.
//
//

import Foundation
import CoreData

// MARK: - PaymentProviderItem
public extension DatabaseModels {
    @objc(PaymentProviderItem)
    class PaymentProviderItem: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var id: Int64
        @NSManaged public var name: String

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<PaymentProviderItem> {
            NSFetchRequest<PaymentProviderItem>(entityName: "PaymentProviderItem")
        }

        static public func fetch() -> NSFetchRequest<PaymentProviderItem> {
            let request = fetchRequest()

            request.sortDescriptors = [
                NSSortDescriptor(keyPath: \PaymentProviderItem.id, ascending: true)
            ]

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.PaymentProviderItem: Identifiable {
}
