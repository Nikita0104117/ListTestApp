//
//  PaymentProviderItem.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import CoreData

// MARK: - PaymentProviderItem
public extension DatabaseModels {
    @objc(LinkedInfo)
    class LinkedInfo: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var name: String
        @NSManaged public var url: String

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<LinkedInfo> {
            NSFetchRequest<LinkedInfo>(entityName: "LinkedInfo")
        }

        static public func fetch() -> NSFetchRequest<LinkedInfo> {
            let request = fetchRequest()

            request.sortDescriptors = .init()

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.LinkedInfo: Identifiable {
}
