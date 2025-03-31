//
//  Database.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import CoreData
import Extensions

public class Database: DatabaseProtocol {
    // MARK: - Public Properties
    public var context: NSManagedObjectContext { _context }

    // MARK: - Private Properties
    private var _context: NSManagedObjectContext {
        persistanceManager.viewContext
    }

    // MARK: - Private Dependencies
    private let persistanceManager: PersistenceManagerProtocol

    // MARK: - Init
    public init(persistanceManager: PersistenceManagerProtocol) {
        self.persistanceManager = persistanceManager
    }

    // MARK: - DatabaseProtocol
    @discardableResult
    public func create<T: NSManagedObject>(mutating: @escaping (T) -> Void) async -> T {
        await _context.perform {
            let item: T = .init(context: self._context)
            mutating(item)
            self.saveContext()

            return item
        }
    }

    public func read<T: NSManagedObject, Result>(
        ofType type: T.Type,
        sortDescriptors: [NSSortDescriptor],
        fetchLimit: Int? = nil,
        offset: Int = 0,
        predicate: NSPredicate? = nil,
        mapper: @escaping ((T) -> Result)
    ) async -> [Result] {
        await _context.perform {
            let request = T.fetchRequest()
            request.sortDescriptors = sortDescriptors
            if let fetchLimit = fetchLimit {
                request.fetchLimit = fetchLimit
            }
            request.fetchOffset = offset
            request.predicate = predicate

            do {
                let result = try self._context.fetch(request)
                guard let result = result as? [T] else {
                    return []
                }
                let mappedResult = result.map(mapper)
                return mappedResult
            } catch {
                // Consider logging the error here
                return []
            }
        }
    }

    public func update<T: NSManagedObject>(item: T, mutating: @escaping (T) -> Void) async {
        await _context.perform {
            mutating(item)
            self.saveContext()
        }
    }

    public func delete<T: NSManagedObject>(items: [T]) async {
        await _context.perform {
            for item in items {
                self._context.delete(item)
            }
            self.saveContext()
        }
    }
}

// MARK: - Private Properties
private extension Database {
    func saveContext() {
//        _context.saveContext()
    }
}
