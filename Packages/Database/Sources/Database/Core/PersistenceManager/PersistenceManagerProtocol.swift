//
//  PersistenceManagerProtocol.swift
//

import Foundation
import CoreData

// MARK: - PersistenceManagerProtocol
public protocol PersistenceManagerProtocol: AnyObject {
    var viewContext: NSManagedObjectContext { get }

    func drop()
}
