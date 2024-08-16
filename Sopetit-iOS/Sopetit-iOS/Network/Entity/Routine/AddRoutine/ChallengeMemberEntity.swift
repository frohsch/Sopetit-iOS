//
//  ChallengeMemberEntity.swift.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/15/24.
//

import Foundation

struct ChallengeMemberEntity: Codable {
    let routineID, themeID: Int
    let themeName, title, content, detailContent: String
    let place, timeTaken: String

    enum CodingKeys: String, CodingKey {
        case routineID = "routineId"
        case themeID = "themeId"
        case themeName, title, content, detailContent, place, timeTaken
    }
}

extension ChallengeMemberEntity {
    
    static func challengeMemberInitial() -> ChallengeMemberEntity {
        return ChallengeMemberEntity(routineID: 0,
                                        themeID: 0,
                                     themeName: "",
                                     title: "",
                                     content: "",
                                     detailContent: "",
                                     place: "",
                                     timeTaken: "")
    }
}
