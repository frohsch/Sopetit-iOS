//
//  ChallengeRoutineEntity.swift
//  Sopetit-iOS
//
//  Created by Minjoo Kim on 6/25/24.
//

import Foundation

struct ChallengeRoutine: Codable {
    let theme: String
    let routine: String
}

extension ChallengeRoutine {
    static func dummy() -> ChallengeRoutine {
//        return ChallengeRoutine(theme: "관계 쌓기", routine: "주변인의 관심사와 작은 변화를 기록해보고,\n그 사람의 장점을 생각해보기")
        return ChallengeRoutine(theme: "", routine: "")
    }
}
