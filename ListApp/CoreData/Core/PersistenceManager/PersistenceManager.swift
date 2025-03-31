//
//  PersistenceManager.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import CoreData

// MARK: - PersistenceManager

/// Note: Create separatelly Core Data Tables to store persistent data and in memory data
/// to avoid potential issues like: `warning: Multiple NSEntityDescriptions claim the NSManagedObject subclass 'Item' so +entity is unable to disambiguate.`
public class PersistenceManager: PersistenceManagerProtocol {
    private enum Constants {
        static let folderName: String = "database"
        static let table = "DatabaseTable"
        static let databaseExtension: String = "sqlite"
        static let modelFileExtension: String = "momd"
        static let inMemoryStorePath = "/dev/null"
    }

    // MARK: - FileUtils
    enum FileUtils {
        /// WARNING: using the same table for persisting and im memory containers will trigger warning:
        /// ---
        /// ``warning: Multiple NSEntityDescriptions claim the NSManagedObject subclass <MODEL> so +entity is unable to disambiguate.``
        static var fileName: String {
            "\(Constants.table).\(Constants.databaseExtension)"
        }

        static public var directoryURL: URL {
            let defaultDirectoryURL = NSPersistentContainer.defaultDirectoryURL()
            let databaseDirectory = defaultDirectoryURL
//                .appendingPathComponent(Constants.folderName)

            return databaseDirectory
        }

        static public func databaseFileURL(database name: String) -> URL? {
//            let bundle = Bundle.module
//            let url = bundle.url(forResource: name, withExtension: Constants.modelFileExtension)

            return nil//url
        }

        static public func storePath(inMemory: Bool) -> URL {
            if inMemory {
                return .init(fileURLWithPath: Constants.inMemoryStorePath)
            }

            return self.directoryURL.appendingPathComponent(Self.fileName)
        }
    }

    // MARK: - Public Propetrties
    public let container: NSPersistentContainer
    public var viewContext: NSManagedObjectContext { container.viewContext }

    // MARK: - Private Properties
    private let inMemory: Bool

    // MARK: - Inits
    public init(inMemory: Bool = false) {
        let name = Constants.table
        guard
            let url = FileUtils.databaseFileURL(database: name),
            let managedObjectModel: NSManagedObjectModel = .init(contentsOf: url)
        else { preconditionFailure() }

        self.inMemory = inMemory
        self.container = NSPersistentContainer(name: name, managedObjectModel: managedObjectModel)
        self.configureContainer(inMemory: inMemory)
    }

    public func drop() {
        let url = FileUtils.storePath(inMemory: inMemory)
        let coordinator = self.container.persistentStoreCoordinator
        // Destroy
        // TODO: add persisting `type: .sqlite` to local variable to clean coordinator with designated type from itself
        try? coordinator.destroyPersistentStore(at: url, type: .sqlite)
        // Re-create
        _ = try? coordinator.addPersistentStore(type: .sqlite, at: url)
    }
}

// MARK: - Private Methods
private extension PersistenceManager {
    func configureContainer(inMemory: Bool) {
        let storeURL = FileUtils.storePath(inMemory: inMemory)
        let description = NSPersistentStoreDescription(url: storeURL)

        description.shouldMigrateStoreAutomatically = true
        description.shouldInferMappingModelAutomatically = true
        container.persistentStoreDescriptions = [description]
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                fatalError("❗️ Unresolved error \(error), \(error.userInfo)")
            }

            debugPrint("✅\(storeDescription.configuration ?? "") Database loaded")
        }
    }
}
