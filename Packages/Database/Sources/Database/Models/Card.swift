//
//  Card.swift
//  BelotPay
//
//  Created by Vyacheslav Razumeenko on 26.09.2024.
//
//

import Foundation
import CoreData

// MARK: - Card
public extension DatabaseModels {
    @objc(Card)
    class Card: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var id: Int64
        @NSManaged public var userId: Int64
        @NSManaged public var cardNumber: String
        @NSManaged public var updatedAt: String
        @NSManaged public var createdAt: String
        @NSManaged public var isDefault: Bool
        @NSManaged public var paymentItem: PaymentProviderItem?

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
            NSFetchRequest<Card>(entityName: "Card")
        }

        static public func fetch() -> NSFetchRequest<Card> {
            let request = fetchRequest()

            request.sortDescriptors = .init()

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.Card: Identifiable {
}
