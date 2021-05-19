//
//  GameSession.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 21.03.2021.
//

import Foundation

class GameSession {
    
    private var questionsForGame: [Question]
    private let questionSequenceStrategy: ShuffleQuestionStrategy
    
    var currentQuestion: Question
    let questionsInSession: Int
    var wrightAnswersCount = Observable<Int>.init(0)
    
    enum CheckAnswerResult {
        case wrightAndContinue, wrightAndFinish, wrongAndFinish, isNoQuestion
    }
    
    func checkAnswerAndGoNext (answer: String) -> CheckAnswerResult? {
                
        if answer == currentQuestion.whriteAnswer, self.questionsForGame.count != 0 {
            
            self.wrightAnswersCount.value += 1
            self.currentQuestion = questionsForGame.remove(at: 0)
            
            return .wrightAndContinue
            
        } else if answer == currentQuestion.whriteAnswer, self.questionsForGame.count == 0 {
            
            self.wrightAnswersCount.value += 1
            
            return .wrightAndFinish
            
        } else {
            
            return .wrongAndFinish
            
        }
    }
    
    init?(questions: [Question], shuffled: Bool) {
        
        self.questionSequenceStrategy = shuffled ? ShuffledQuestions() : UnShuffledQuestions()
        
        self.questionsForGame = questionSequenceStrategy.fetchQuestions()
        
        self.questionsInSession = questionsForGame.count
        
        self.currentQuestion = questionsForGame.remove(at: 0)
        
    }
}
