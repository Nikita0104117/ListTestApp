//
//  Card.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import CoreData

// MARK: - Card
public extension DatabaseModels {
    @objc(Result)
    class Result: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var id: Int64
        @NSManaged public var name: String
        @NSManaged public var status: String
        @NSManaged public var species: String
        @NSManaged public var type: String
        @NSManaged public var gender: String
        @NSManaged public var origin: LinkedInfo
        @NSManaged public var location: LinkedInfo
        @NSManaged public var image: String
        @NSManaged public var url: String
        @NSManaged public var created: String

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
            NSFetchRequest<Result>(entityName: "Result")
        }

        static public func fetch() -> NSFetchRequest<Result> {
            let request = fetchRequest()

            request.sortDescriptors = .init()

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.Result: Identifiable {
}
