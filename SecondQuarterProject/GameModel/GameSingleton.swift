//
//  GameSingleton.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 24.02.2021.
//

import Foundation

class GameSingleton {
    
    static let shared = GameSingleton()
    
    var session: GameSession!
    
    let dateFormatter = DateFormatter()
    
    private(set) var records: [Record] {
        didSet {
            careTakerMemento.saveParameter(parametr: records)
        }
    }
    
    private(set) var settings: [GamePlaySettings : Bool] {
        didSet {
            careTakerMemento.saveParameter(parametr: settings)
        }
    }

    private let careTakerMemento = MementoCaretaker()

    private init() {
        records = careTakerMemento.loadParameter(defaultValue: [Record]())
        settings = careTakerMemento.loadParameter(defaultValue: defaultSettings)
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMM yyyy HH:MM"
    }

    func addRecord(_ record: Record) {
        records.append(record)
    }

    func clearRecords() {
        records.removeAll()
    }

    func changeSettingState (settingCase: GamePlaySettings) -> Void {
        guard let value = settings[settingCase] else { return }
        settings[settingCase] = value ? false : true
    }
}


