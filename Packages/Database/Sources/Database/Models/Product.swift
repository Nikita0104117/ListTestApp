//
//  Product.swift
//  BelotPay
//
//  Created by Vyacheslav Razumeenko on 24.09.2024.
//
//

import Foundation
import CoreData

// MARK: - Product
public extension DatabaseModels {
    @objc(Product)
    class Product: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var product: ProductItem?
        @NSManaged public var beacon: Beacon?
        @NSManaged public var bus: Bus?
        @NSManaged public var route: Route?

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<Product> {
            NSFetchRequest<Product>(entityName: "Product")
        }

        static public func fetch() -> NSFetchRequest<Product> {
            let request = fetchRequest()

            request.sortDescriptors = .init()

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.Product: Identifiable { }
