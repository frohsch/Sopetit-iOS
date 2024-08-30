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
    let introductionURL: String
    let name: String
    let profileImageURL: String
    let tags: [String]
    let themeID: Int
    let description, themeName, comment: String

    enum CodingKeys: String, CodingKey {
        case makerID = "makerId"
        case introductionURL = "introductionUrl"
        case name
        case profileImageURL = "profileImageUrl"
        case tags
        case themeID = "themeId"
        case description, themeName, comment
    }
}

extension MakersEntity {
    
    static func makersInitialEntity() -> MakersEntity {
        return MakersEntity(makers: [Maker(makerID: 0, 
                                           introductionURL: "",
                                           name: "",
                                           profileImageURL: "",
                                           tags: [],
                                           themeID: 0,
                                           description: "",
                                           themeName: "",
                                           comment: "")])
    }
}
