//
//  RoutineChoiceEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 2024/01/10.
//

import Foundation

struct RoutineChoiceEntity: Codable {
    let themes: [SelectedTheme]
}

// MARK: - Theme
struct SelectedTheme: Codable {
    let themeID: Int
    let routines: [Routine]

    enum CodingKeys: String, CodingKey {
        case themeID = "themeId"
        case routines
    }
}

// MARK: - Routine
struct Routine: Codable {
    let routineID: Int
    let content: String

    enum CodingKeys: String, CodingKey {
        case routineID = "routineId"
        case content
    }
}
