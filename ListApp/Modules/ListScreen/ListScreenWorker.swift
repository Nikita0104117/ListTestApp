//
//  ListScreenWork.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import UIKit

private typealias Module = ListScreenModule

extension Module {
    class Worker: ListScreenWorkerLogic {
        private let characterTarget: CharacterService
        private var pageInfoModel: Module.Models.PageInfoModel?

        init(characterTarget: CharacterService) {
            self.characterTarget = characterTarget
        }

        func fetchData(_ isRefresh: Bool) async -> [ResponseModels.CharacterModels.ResultModel] {
            if isRefresh { pageInfoModel = nil }

            do {
                let charactersModel = try await characterTarget.fetchCharacter(with: pageInfoModel?.nextPage ?? 1)
                self.pageInfoModel = .init(nexPageurl: charactersModel.info.next)

                return charactersModel.results
            } catch let error {
                print("Error: \(error.localizedDescription)")
                return []
            }
        }
    }
}
