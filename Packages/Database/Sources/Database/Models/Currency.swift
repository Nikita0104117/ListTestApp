//
//  Currency.swift
//  BelotPay
//
//  Created by Vyacheslav Razumeenko on 23.09.2024.
//
//

import Foundation
import CoreData

// MARK: - Currency
public extension DatabaseModels {
    @objc(Currency)
    class Currency: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var id: Int64
        @NSManaged public var name: String
        @NSManaged public var symbol: String
        @NSManaged public var isoCode: String
        @NSManaged public var isDefault: Bool

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<Currency> {
            NSFetchRequest<Currency>(entityName: "Currency")
        }

        static public func fetch() -> NSFetchRequest<Currency> {
            let request = fetchRequest()

            request.sortDescriptors = .init()

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.Currency: Identifiable { }
