//
//  CharacterService.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation
import Networking

protocol CharacterService {
    func fetchCharacter(with nextPageNumber: Int) async throws -> ResponseModels.CharacterModels.CharacterModel
}

extension RequestRouter {
    enum Characters {
        case fetchCharacter(_ nextPageNumber: Int)
    }
}

extension RequestRouter.Characters: AnyNetworkRouter {
    var path: Endpoint {
        switch self {
            case .fetchCharacter:
                return "/character"
        }
    }

    var method: HTTPMethod {
        switch self {
            case .fetchCharacter:
                return .get
        }
    }

    var parameters: Encodable? {
        switch self {
            case .fetchCharacter(let data):
                return ["page": data]
        }
    }

    var withSnakeStyleEncoder: Bool { false }

    var addAuth: Bool { false }
}
