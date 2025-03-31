//
//  Card.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import CoreData

// MARK: - Card
public extension DatabaseModels {
    @objc(Result)
    class Result: NSManagedObject {
        // MARK: - Properties
        @NSManaged public var id: Int64
        @NSManaged public var name: String
        @NSManaged public var status: String
        @NSManaged public var species: String
        @NSManaged public var type: String
        @NSManaged public var gender: String
        @NSManaged public var origin: LinkedInfo?
        @NSManaged public var location: LinkedInfo?
        @NSManaged public var image: String
        @NSManaged public var url: String
        @NSManaged public var created: String

        // MARK: - Methods
        @nonobjc public class func fetchRequest() -> NSFetchRequest<Result> {
            NSFetchRequest<Result>(entityName: "Result")
        }

        static public func fetch() -> NSFetchRequest<Result> {
            let request = fetchRequest()

            request.sortDescriptors = .init()

            return request
        }
    }
}

// MARK: - Identifiable
extension DatabaseModels.Result: Identifiable {
}

extension DatabaseModels.Result {
    func update(from dto: ResponseModels.CharacterModels.ResultModel) {
        self.id = .init(dto.id)
        self.name = dto.name
        self.created = dto.created
        self.status = dto.status
        self.species = dto.species
        self.type = dto.type
        self.gender = dto.gender
        self.image = dto.image
        self.url = dto.url

        NSManagedObject.update(
            item: self,
            keyPath: \.origin
        ) {
            let request = DatabaseModels.LinkedInfo.fetch()
            request.predicate = .init(format: "name == %@", dto.origin.name)
            request.fetchLimit = 1
            return request
        } onUpdate: {
            $0.update(from: dto.origin)
        }

        NSManagedObject.update(
            item: self,
            keyPath: \.location
        ) {
            let request = DatabaseModels.LinkedInfo.fetch()
            request.predicate = .init(format: "name == %@", dto.location.name)
            request.fetchLimit = 1
            return request
        } onUpdate: {
            $0.update(from: dto.location)
        }
    }
}
