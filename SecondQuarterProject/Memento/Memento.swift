//
//  Memento.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 17.03.2021.
//

import Foundation

class MementoCaretaker {
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    private let keyForRecords = "RecordsOfGame"
    private let keyForSettings = "GameSettings"
    private let keyForQuestions = "GameQuestions"
    
    func saveRecords(records: [Record]) {
        do {
            let data: Memento = try encoder.encode(records)
            UserDefaults.standard.setValue(data, forKey: keyForRecords)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadRecords() -> [Record] {
        guard let data: Memento = UserDefaults.standard.data(forKey: keyForRecords) else {
            return []
        }
        
        do {
            return try decoder.decode([Record].self, from: data)
        } catch {
            print(error.localizedDescription)
            return []
        }
    }
    
    func saveSettings(settings: [GamePlaySettings : Bool]) {
        do {
            let data: Memento = try encoder.encode(settings)
            UserDefaults.standard.setValue(data, forKey: keyForSettings)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadSettings() -> [GamePlaySettings : Bool] {
        guard let data: Memento = UserDefaults.standard.data(forKey: keyForSettings) else {
            return defaultSettings
        }
        
        do {
            return try decoder.decode([GamePlaySettings : Bool].self, from: data)
        } catch {
            print(error.localizedDescription)
            return defaultSettings

        }
    }
    
    func saveQuestions(questions: [Question]) {
        do {
            let data: Memento = try encoder.encode(questions)
            UserDefaults.standard.setValue(data, forKey: keyForQuestions)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadQuestions() -> [Question] {
        guard let data: Memento = UserDefaults.standard.data(forKey: keyForQuestions) else {
            return defaultQuestionsBase
        }
        
        do {
            return try decoder.decode([Question].self, from: data)
        } catch {
            print(error.localizedDescription)
            return defaultQuestionsBase

        }
    }
}
