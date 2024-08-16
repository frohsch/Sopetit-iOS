//
//  DailyThemeEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/12/24.
//

import Foundation

struct DailyThemeEntity: Codable {
    let routines: [Routines]
}

// MARK: - Routine
struct Routines: Codable {
    let id: Int
    let content: String
    let existedInMember: Bool
}
