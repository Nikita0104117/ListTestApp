//
//  ProductItem.swift
//  BelotPay
//
//  Created by Vyacheslav Razumeenko on 24.09.2024.
//
//

import Foundation
import CoreData

// MARK: - ProductItem
public extension DatabaseModels {
    @objc(ProductItem)
    class ProductItem: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var id: Int64
        @NSManaged public var name: String
        @NSManaged public var price: String
        @NSManaged public var currencyId: Int64
        @NSManaged public var createdAt: String
        @NSManaged public var updatedAt: String
        @NSManaged public var deletedAt: String?
        @NSManaged public var currency: Currency?

        @NSManaged private var paymentType: String

        public var paymentTypeValue: Trip.ProductType {
            get { .init(rawValue: paymentType) ?? .unknown }
            set { paymentType = newValue.rawValue }
        }

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductItem> {
            NSFetchRequest<ProductItem>(entityName: "ProductItem")
        }

        static public func fetch() -> NSFetchRequest<ProductItem> {
            let request = fetchRequest()

            request.sortDescriptors = .init()

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.ProductItem: Identifiable { }
