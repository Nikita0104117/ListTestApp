//
//  RestCharacter.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import Networking

struct RestCharacterService: AnyNetworkService {
    let restClient: NetworkingSessionProtocol
}

extension RestCharacterService: CharacterService {
    func fetchCharacter(with nextPageNumber: Int) async throws -> ResponseModels.CharacterModels.CharacterModel {
        try await restClient.makeRequest(RequestRouter.Characters.fetchCharacter(nextPageNumber))
    }
}
