//
//  GameSingleton.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 24.02.2021.
//

import Foundation

class GameSingleton {
    
    static let shared = GameSingleton()
    
    var session: GameSession?
    
    private(set) var records: [Record] {
        didSet {
            caretakerMemento.saveRecords(records: records)
        }
    }

    private let caretakerMemento = MementoCaretaker()

    private init() {
        records = caretakerMemento.loadRecords()
        settings = caretakerMemento.loadSettings()
    }

    func addRecord(_ record: Record) {
        records.append(record)
    }

    func clearRecords() {
        records.removeAll()
    }
    
    private(set) var settings: [GamePlaySettings : Bool] {
        didSet {
            caretakerMemento.saveSettings(settings: settings)
        }
    }

    func changeSettingState (settingCase: GamePlaySettings) -> Void {
        guard let value = settings[settingCase] else { return }
        settings[settingCase] = value ? false : true
    }
    
}


