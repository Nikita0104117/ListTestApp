//
//  Bus.swift
//  BelotPay
//
//  Created by Vyacheslav Razumeenko on 17.09.2024.
//
//

import Foundation
import CoreData

// MARK: - Bus
public extension DatabaseModels {
    @objc(Bus)
    class Bus: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var id: Int64
        @NSManaged public var driverId: Int64
        @NSManaged public var descriptionValue: String
        @NSManaged public var capacity: Int64
        @NSManaged public var carrierId: Int64
        @NSManaged public var tailNumber: String
        @NSManaged public var plate: String
        @NSManaged public var model: String
        @NSManaged public var createdAt: String
        @NSManaged public var updatedAt: String
        @NSManaged public var beaconId: Int64
        @NSManaged public var routeId: Int64
        @NSManaged public var status: String

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<Bus> {
            NSFetchRequest<Bus>(entityName: "Bus")
        }

        static public func fetch() -> NSFetchRequest<Bus> {
            let request = fetchRequest()

            request.sortDescriptors = .init()

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.Bus: Identifiable { }
