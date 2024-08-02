//
//  ThemeSelectEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import Foundation

struct ThemeSelectEntity: Codable {
    let themes: [Theme]
}

struct Theme: Codable {
    let themeID: Int
    let title, subTitle, description: String

    enum CodingKeys: String, CodingKey {
        case themeID = "themeId"
        case title, subTitle, description
    }
}
