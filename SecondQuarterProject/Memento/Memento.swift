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
    private enum Keys: String {
        case records = "RecordsOfGame"
        case settings = "GameSettings"
        case questions = "GameQuestions"
    }
    
    func saveParameter <T: Codable> (parametr: T) {
        switch parametr {
        case let param as Array<Record>:
            do {
                let data: Memento = try encoder.encode(param)
                UserDefaults.standard.setValue(data, forKey: Keys.records.rawValue)
            } catch {
                print(error.localizedDescription)
            }
        case let param as Dictionary<GamePlaySettings, Bool>:
            do {
                let data: Memento = try encoder.encode(param)
                UserDefaults.standard.setValue(data, forKey: Keys.settings.rawValue)
            } catch {
                print(error.localizedDescription)
            }
        case let param as Array<Question>:
            do {
                let data: Memento = try encoder.encode(param)
                UserDefaults.standard.setValue(data, forKey: Keys.questions.rawValue)
            } catch {
                print(error.localizedDescription)
            }
        default:
            print("Memento is not tuned for that parameter type: \(type(of: parametr))")
        }
    }
    
    func loadParameter<T>(defaultValue value: T) -> T {
        var param: T = value
        switch param {
        
        case _ as Array<Record>:
            guard let data: Memento = UserDefaults.standard.data(forKey: Keys.records.rawValue) else { return value }
            do {
                param = try decoder.decode([Record].self, from: data) as! T
            } catch {
                print(error.localizedDescription)
            }
        case _ as Dictionary<GamePlaySettings, Bool>:
            guard let data: Memento = UserDefaults.standard.data(forKey: Keys.settings.rawValue) else { return value }
            do {
                param = try decoder.decode([GamePlaySettings : Bool].self, from: data) as! T
            } catch {
                print(error.localizedDescription)
            }
        case _ as Array<Question>:
            guard let data: Memento = UserDefaults.standard.data(forKey: Keys.questions.rawValue) else { return value }
            do {
                param = try decoder.decode([Question].self, from: data) as! T
            } catch {
                print(error.localizedDescription)
            }
        default:
            print("Memento is not tuned for that parameter type")
            return value
        }
        
        return param
        
    }
}
