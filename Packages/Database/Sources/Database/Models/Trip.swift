//
//  Trip.swift
//  BelotPay
//
//  Created by Vyacheslav Razumeenko on 17.09.2024.
//
//

import Foundation
import CoreData

// MARK: - Trip
public extension DatabaseModels {
    @objc(Trip)
    class Trip: NSManagedObject {
        public override var debugDescription: String {
            """
                id: \(id)
                orderId: \(orderId)
                productName: \(productName)
                price: \(price)
                totalPrice: \(totalPrice)
                ticketNumber: \(ticketNumber)
                status: \(status)
                tripStatus: \(tripStatus)
                bus: \(bus)
                route: \(route)
                beacon: \(beacon)
                product: \(product)
            """
        }

        // MARK: - Properties
        @NSManaged public var id: Int64
        @NSManaged public var orderId: Int64
        @NSManaged public var productName: String
        @NSManaged public var price: String
        @NSManaged public var totalPrice: String
        @NSManaged public var routeName: String
        @NSManaged public var createdAt: String
        @NSManaged public var updatedAt: String
        @NSManaged public var finishedAt: String?
        /// Represents ticket-related properties from the backend:
        ///
        /// - Route: `/buy-ticket`
        ///   - Property: `order_items->item->id`
        /// - Route: `/trips?limit=[number]&offset=[number]`
        ///   - Property: `ticket_number`
        @NSManaged public var ticketNumber: Int64
        @NSManaged public var routeStartPoint: String
        @NSManaged public var routeEndPoint: String
        @NSManaged public var bus: Bus?
        @NSManaged public var route: Route?
        @NSManaged public var beacon: Beacon?
        @NSManaged public var currency: Currency?
        /// Needs for offline mode. When user starts trip without internet connection on creating `Trip` object must be filled this property.
        @NSManaged public var product: Product?

        @NSManaged private var productType: String
        @NSManaged private var status: String
        @NSManaged private var tripStatus: String

        public var productTypeValue: ProductType {
            get { .init(rawValue: productType) ?? .fixed }
            set { productType = newValue.rawValue }
        }
        public var statusValue: Status {
            get { .init(rawValue: status) ?? .unknown }
            set { status = newValue.rawValue }
        }
        public var tripStatusValue: TripStatus {
            get { .init(rawValue: tripStatus) ?? .unknown }
            set { tripStatus = newValue.rawValue }
        }

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<Trip> {
            NSFetchRequest<Trip>(entityName: "Trip")
        }

        static public func fetch() -> NSFetchRequest<Trip> {
            let request = fetchRequest()

            request.sortDescriptors = [
                NSSortDescriptor(keyPath: \Trip.id, ascending: false)
            ]

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.Trip: Identifiable { }

// MARK: - ProductType
public extension DatabaseModels.Trip {
    enum ProductType: String {
        case time = "time"
        case distance = "distance"
        case fixed = "fixed"

        case unknown = "-"
    }
}

// MARK: - Status
public extension DatabaseModels.Trip {
    enum Status: String {
        case pending = "pending"
        case processing = "processing"
        // on start trip status on BE
        case pendingFinalization = "pending_finalization"
        // end status on BE
        case paid = "paid"
        case cancelled = "cancelled"
        case refunded = "refunded"

        // just local cases
        case paidLocally = "paid_locally"

        case unknown = "unknown"
    }
}

// MARK: - TripStatus
public extension DatabaseModels.Trip {
    enum TripStatus: String {
        // on start trip status on BE
        case ongoing = "ongoing"
        case paidOngoing = "paid_ongoing"
        // end status on BE
        case finished = "finished"

        case finishedLocally = "finished_locally"

        case unknown = "unknown"

        public var isOngoing: Bool { self == .ongoing || self == .paidOngoing }
        public var isFinished: Bool { self == .finished || self == .finishedLocally }
    }
}
