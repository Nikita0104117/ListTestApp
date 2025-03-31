//
//  ListScreenWork.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import UIKit
import Networking

private typealias Module = ListScreenModule

extension Module {
    class Worker: ListScreenWorkerLogic {
        private let characterTarget: CharacterService
        private let connectivity: Connectivity
        private let database: DatabaseProtocol

        private var pageInfoModel: Module.Models.PageInfoModel?

        init(characterTarget: CharacterService, connectivity: Connectivity, database: DatabaseProtocol) {
            self.characterTarget = characterTarget
            self.connectivity = connectivity
            self.database = database
        }

        func fetchData(_ isRefresh: Bool) async -> [ResponseModels.CharacterModels.ResultModel] {
            if isRefresh { pageInfoModel = nil }

            if !connectivity.isReachableFlag { return await fetchCoreData() }

            do {
                let charactersModel = try await characterTarget.fetchCharacter(with: pageInfoModel?.nextPage ?? 1)
                self.pageInfoModel = .init(nexPageurl: charactersModel.info.next)

                await self.saveCoreData(with: charactersModel.results)

                return charactersModel.results
            } catch let error {
                print("Error: \(error.localizedDescription)")
                return await fetchCoreData()
            }
        }

        private func fetchCoreData() async -> [ResponseModels.CharacterModels.ResultModel] {
            await database.read(
                ofType: DatabaseModels.Result.self,
                sortDescriptors: []
            ) { object in
                    .init(
                        id: .init(object.id),
                        name: object.name,
                        status: object.status,
                        species: object.species,
                        type: object.type,
                        gender: object.gender,
                        origin: .init(name: object.origin?.name ?? "", url: object.origin?.url ?? ""),
                        location: .init(name: object.location?.name ?? "", url: object.location?.url ?? ""),
                        image: object.image,
                        url: object.url,
                        created: object.created
                    )
            }
        }

        private func saveCoreData(with data: [ResponseModels.CharacterModels.ResultModel]) async {
            for item in data {
                await database.create { [item] (object: DatabaseModels.Result) in
                    object.update(from: item)
                }
            }
        }
    }
}
