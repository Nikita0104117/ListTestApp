//
//  Beacon+CoreDataClass.swift
//  BelotPay
//
//  Created by Vyacheslav Razumeenko on 12.09.2024.
//
//

import Foundation
import CoreData

// MARK: - Beacon
public extension DatabaseModels {
    @objc(Beacon)
    class Beacon: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var id: Int64
        @NSManaged public var uuid: String
        @NSManaged public var major: Int64
        @NSManaged public var minor: Int64
        @NSManaged public var mac: String
        @NSManaged public var status: String
        @NSManaged public var carrierId: Int64
        @NSManaged public var createdAt: String
        @NSManaged public var updatedAt: String

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<Beacon> {
            NSFetchRequest<Beacon>(entityName: "Beacon")
        }

        static public func fetch() -> NSFetchRequest<Beacon> {
            let request = fetchRequest()

            request.sortDescriptors = [
                NSSortDescriptor(keyPath: \Beacon.id, ascending: false)
            ]

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.Beacon: Identifiable {
}
