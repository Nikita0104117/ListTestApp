//
//  CharcaterInfoModel.swift
//  ListApp
//
//  Created by Nikita Omelchenko on 31.03.2025.
//

import Foundation

extension ResponseModels {
    enum CharacterModels { }
}

struct LinkedInfoModel: Decodable {
    let name: String
    let url: String
}

extension ResponseModels.CharacterModels {
    struct CharacterModel: Decodable {
        let info: InfoModel
        let results: [ResultModel]
    }
    struct InfoModel: Decodable {
        let count: Int
        let pages: Int
        let next: String
    }

    struct ResultModel: Decodable {
        let id: Int
        let name: String
        let status: String
        let species: String
        let type: String
        let gender: String
        let origin: LinkedInfoModel
        let location: LinkedInfoModel
        let image: String
        let url: String
        let created: String
    }
}
