//
//  Route+CoreDataProperties.swift
//  BelotPay
//
//  Created by Vyacheslav Razumeenko on 01.08.2024.
//
//

import Foundation
import CoreData

// MARK: - Route
public extension DatabaseModels {
    @objc(Route)
    class Route: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var id: Int64
        @NSManaged public var name: String
        @NSManaged public var startPoint: String
        @NSManaged public var endPoint: String
        @NSManaged public var routeNumber: String
        @NSManaged public var duration: Int64
        @NSManaged public var distance: String
        @NSManaged public var municipalityId: Int64
        @NSManaged public var productId: Int64
        @NSManaged public var createdAt: String
        @NSManaged public var updatedAt: String

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<Route> {
            NSFetchRequest<Route>(entityName: "Route")
        }

        static public func fetch() -> NSFetchRequest<Route> {
            let request = fetchRequest()

            request.sortDescriptors = .init()

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.Route: Identifiable { }
