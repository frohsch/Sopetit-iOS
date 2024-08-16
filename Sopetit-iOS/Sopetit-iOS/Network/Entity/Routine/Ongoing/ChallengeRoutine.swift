//
//  ChallengeRoutineEntity.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/25/24.
//

import Foundation

struct ChallengeRoutine: Codable {
    let routineId: Int?
    let themeId: Int?
    let themeName: String?
    let title: String?
    let content: String?
    let detailContent: String?
    let place: String?
    let timeTaken: String?
}
