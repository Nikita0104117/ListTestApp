//
//  DatabaseProtocol.swift
//

import Foundation
import CoreData

public protocol DatabaseProtocol: AnyObject {
    var context: NSManagedObjectContext { get }

    @discardableResult
    func create<T: NSManagedObject>(mutating: @escaping (T) -> Void) async -> T
    func read<T: NSManagedObject, Result>(
        ofType type: T.Type,
        sortDescriptors: [NSSortDescriptor],
        fetchLimit: Int?,
        offset: Int,
        predicate: NSPredicate?,
        mapper: @escaping (T) -> Result
    ) async -> [Result]
    func update<T: NSManagedObject>(item: T, mutating: @escaping (T) -> Void) async
    func delete<T: NSManagedObject>(items: [T]) async
}

public extension DatabaseProtocol {
    func read<T: NSManagedObject, Result>(
        ofType type: T.Type,
        sortDescriptors: [NSSortDescriptor] = .init(),
        fetchLimit: Int? = nil,
        offset: Int = 0,
        predicate: NSPredicate? = nil,
        mapper: @escaping (T) -> Result
    ) async -> [Result] {
        await read(
            ofType: type,
            sortDescriptors: sortDescriptors,
            fetchLimit: fetchLimit,
            offset: offset,
            predicate: predicate,
            mapper: mapper
        )
    }
}
