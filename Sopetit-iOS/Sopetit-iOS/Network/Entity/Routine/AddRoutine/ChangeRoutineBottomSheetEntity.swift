//
//  ChangeRoutineBottomSheetEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/15/24.
//

import Foundation

struct ChangeRoutineBottomSheetEntity {
    let existThemeID: Int
    let existContent: String
    let choiceThemeID: Int
    let choiceContent: String
}

extension ChangeRoutineBottomSheetEntity {
    
    static func changeBottomSheetInitial() -> ChangeRoutineBottomSheetEntity {
        return ChangeRoutineBottomSheetEntity(existThemeID: 0,
                                              existContent: "",
                                              choiceThemeID: 0,
                                              choiceContent: "")
    }
}
