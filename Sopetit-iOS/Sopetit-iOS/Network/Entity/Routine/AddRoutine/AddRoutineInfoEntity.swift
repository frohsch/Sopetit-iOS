//
//  AddRoutineInfoEntity.swift
//  Sopetit-iOS
//
//  Created by 고아라 on 8/13/24.
//

import Foundation

enum AddRoutineTheme: Codable {
    case routine
    case maker
}

struct AddRoutineInfoEntity: Codable {
    let themeStyle: AddRoutineTheme
    let id: Int
    let title: String
    let description: String
}

extension AddRoutineInfoEntity {
    
    static func addRoutineInfoInitial() -> AddRoutineInfoEntity {
        return AddRoutineInfoEntity(themeStyle: .routine,
                                    id: 0,
                                    title: "",
                                    description: "")
    }
}
