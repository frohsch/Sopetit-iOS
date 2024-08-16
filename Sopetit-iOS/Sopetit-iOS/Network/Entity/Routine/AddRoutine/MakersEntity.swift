//
//  MakersEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/11/24.
//

import Foundation

struct MakersEntity: Codable {
    let makers: [Maker]
}

// MARK: - Maker

struct Maker: Codable {
    let makerID: Int
    let content, name: String
    let profileImageURL: String
    let tags: [String]
    let themeID: Int
    let description, themeName, modifier: String

    enum CodingKeys: String, CodingKey {
        case makerID = "makerId"
        case content, name
        case profileImageURL = "profileImageUrl"
        case tags
        case themeID = "themeId"
        case description, themeName, modifier
    }
}

extension MakersEntity {
    
    static func makersInitialEntity() -> MakersEntity {
        return MakersEntity(makers: [Maker(makerID: 0,
                                           content: "",
                                           name: "",
                                           profileImageURL: "",
                                           tags: [],
                                           themeID: 0,
                                           description: "",
                                           themeName: "",
                                           modifier: "")])
    }
}
