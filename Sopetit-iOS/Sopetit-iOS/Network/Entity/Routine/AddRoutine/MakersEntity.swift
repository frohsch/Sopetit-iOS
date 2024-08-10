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
    let makerID, themeID: Int
    let profileImageURL, description, content: String
    let tags: [String]

    enum CodingKeys: String, CodingKey {
        case makerID = "makerId"
        case themeID = "themeId"
        case profileImageURL = "profileImageUrl"
        case description, content, tags
    }
}
