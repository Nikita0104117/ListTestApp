//
//  Untitled.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import CoreData

public extension NSManagedObjectContext {
    func saveContext() {
        guard self.hasChanges else { return }

        do {
            try self.save()
        } catch {
            let nsError: NSError = error as NSError
            fatalError("❗️ Unresolved error on contextSave \(nsError), \(nsError.userInfo)")
        }
    }
}
