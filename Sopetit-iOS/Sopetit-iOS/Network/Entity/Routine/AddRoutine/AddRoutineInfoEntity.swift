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
    let name: String
    let img: String
    let title: String
    let description: String
    let makerUrl: String
}

extension AddRoutineInfoEntity {
    
    static func addRoutineInfoInitial() -> AddRoutineInfoEntity {
        return AddRoutineInfoEntity(themeStyle: .maker,
                                    id: 0,
                                    name: "",
                                    img: "",
                                    title: "",
                                    description: "",
                                    makerUrl: "")
    }
}
