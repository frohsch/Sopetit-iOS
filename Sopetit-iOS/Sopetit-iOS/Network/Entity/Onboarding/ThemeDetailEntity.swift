//
//  RoutineIDEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 7/4/24.
//

import UIKit

struct ThemeDetailEntity {
    let themeTitle: String
    let themeImage: UIImage
}

extension ThemeDetailEntity {
    static func getTheme(id: Int) -> ThemeDetailEntity {
        switch id {
        case 1:
            return ThemeDetailEntity(themeTitle: "관계 쌓기", themeImage: UIImage(resource: .theme1))
        case 2:
            return ThemeDetailEntity(themeTitle: "한 걸음 성장", themeImage: UIImage(resource: .theme5))
        case 3:
            return ThemeDetailEntity(themeTitle: "나와 친해지기", themeImage: UIImage(resource: .theme7))
        case 4:
            return ThemeDetailEntity(themeTitle: "마음 챙김", themeImage: UIImage(resource: .theme2))
        case 5:
            return ThemeDetailEntity(themeTitle: "건강한 몸", themeImage: UIImage(resource: .theme6))
        case 6:
            return ThemeDetailEntity(themeTitle: "통통한 통장", themeImage: UIImage(resource: .theme3))
        case 7:
            return ThemeDetailEntity(themeTitle: "산뜻한 일상", themeImage: UIImage(resource: .theme4))
        default:
            return ThemeDetailEntity(themeTitle: "", themeImage: UIImage())
        }
    }
}
