//
//  HomeEntity.swift
//  Sopetit-iOS
//
//  Created by 티모시 킴 on 1/16/24.
//

struct HomeEntity: Codable {
    let name, dollType: String
    let dailyCottonCount, happinessCottonCount: Int
    let conversations: [String]
}
