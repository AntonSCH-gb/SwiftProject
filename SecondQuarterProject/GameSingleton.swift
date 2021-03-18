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
            recordsCaretaker.saveRecords(records: records)
        }
    }

    private let recordsCaretaker = RecordsCaretaker()

    private init() {
        records = recordsCaretaker.loadRecords()
    }

    func addRecord(_ record: Record) {
        records.append(record)
    }

    func clearRecords() {
        records.removeAll()
    }
}

class GameSession {
    
    var questionsForGame: [Question]
    
    var currentQuestion: Question?
    
    let questionsInSession: Int
    
    var wrightAnswersCount = 0
    
    func checkAnswerAndGoNext (answer: String) -> (wrightAnswer: Bool, finish: Bool) {
        
        guard let currentQuestion = currentQuestion else { return (false, false) }
        
        if answer == currentQuestion.whriteAnswer, self.questionsForGame.count != 0 {
            self.wrightAnswersCount += 10
            self.currentQuestion = self.questionsForGame.remove(at: Int.random(in: 0..<questionsForGame.count))
            return (true, false)
            
        } else if answer == currentQuestion.whriteAnswer, self.questionsForGame.count == 0 {
            self.wrightAnswersCount += 10
            return (true, true)
            
        } else {
            return (false, true)
        }
    }
    
//    func getNextQuestion (answerWasWright: Bool) -> Bool {
//        switch answerWasWright {
//        case true where self.questionsForGame.count != 0:
//            self.wrightAnswersCount += 1
//            self.currentQuestion = self.questionsForGame.remove(at: Int.random(in: 0..<questionsInSession))
//            return true
//        default:
//            return false
//        }
//    }
    
    init(questions: [Question]) {
        self.questionsForGame = questions
        self.questionsInSession = questionsForGame.count
        guard questions.count != 0 else { return }
        self.currentQuestion = self.questionsForGame.remove(at: Int.random(in: 0..<questionsInSession))
        
    }
    
    
}
