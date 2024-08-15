//
//  AddRoutineBottomSheetEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/15/24.
//

import Foundation

struct AddRoutineBottomSheetEntity {
    let content: String
    let description: String
    let time: String
    let place: String
}

extension AddRoutineBottomSheetEntity {
    
    static func bottomSheetInitial() -> AddRoutineBottomSheetEntity {
        return AddRoutineBottomSheetEntity(content: "",
                                           description: "",
                                           time: "",
                                           place: "")
    }
}
