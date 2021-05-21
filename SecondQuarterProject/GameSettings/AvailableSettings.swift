//
//  AvailableSettings.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 19.03.2021.
//

import Foundation

enum GamePlaySettings : String, Codable {
    case shuffleQuestion
}

let defaultSettings = [
    GamePlaySettings.shuffleQuestion : false
]

enum  SettingsWithTransition: String, Codable {
    case addUserQuestion
}

let settingsWithTransition: [SettingsWithTransition : String] = [
    SettingsWithTransition.addUserQuestion : "Добавить свой вопрос"
]
