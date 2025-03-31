//
//  PersistenceManagerProtocol.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import CoreData

// MARK: - PersistenceManagerProtocol
public protocol PersistenceManagerProtocol: AnyObject {
    var viewContext: NSManagedObjectContext { get }

    func drop()
}
