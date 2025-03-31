//
//  NSManagedObject+Extesion.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import CoreData

extension NSManagedObject {
    /// Static method for updating CoreData nested objects.
    /// - Parameters:
    ///   - item: object to update
    ///   - keyPath: path to property for update
    ///   - keyPathFetchRequest: fetch request for keyPath object,
    ///     If nested object doesnt exist it will be created and tried to update itself by `onUpdate` closure.
    ///   - onUpdate: implement update strategy for selected property
    static func update<I: NSManagedObject, T: NSManagedObject & NSFetchRequestResult>(
        item: I,
        keyPath: ReferenceWritableKeyPath<I, T?>,
        keyPathFetchRequest: (() -> NSFetchRequest<T>)? = nil,
        onUpdate: (T) -> Void
    ) {
        guard let context = item.managedObjectContext else { preconditionFailure() }

        if item[keyPath: keyPath] != nil {
            // swiftlint:disable:next force_unwrapping
            onUpdate(item[keyPath: keyPath]!)
            return
        }

        if let fetchRequest = keyPathFetchRequest,
            let fetchedItem = try? context.fetch(fetchRequest()).first {
            onUpdate(fetchedItem)
            item[keyPath: keyPath] = fetchedItem
        } else {
            item[keyPath: keyPath] = .init(context: context)
            // swiftlint:disable:next force_unwrapping
            onUpdate(item[keyPath: keyPath]!)
        }
    }
}
