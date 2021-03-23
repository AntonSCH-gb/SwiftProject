//
//  GameSession.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 21.03.2021.
//

import Foundation

class GameSession {
    
    var questionsForGame: [Question]
    
    var currentQuestion: Question?
    
    let questionsInSession: Int
    
    var wrightAnswersCount = Observable<Int>.init(0)
    
    let questionSequenceStrategy: ShuffleQuestionStrategy
    
    func checkAnswerAndGoNext (answer: String) -> (wrightAnswer: Bool, finish: Bool) {
        
        guard let currentQuestion = currentQuestion else { return (false, false) }
        
        if answer == currentQuestion.whriteAnswer, self.questionsForGame.count != 0 {
            self.wrightAnswersCount.value += 1
            
            self.currentQuestion = questionSequenceStrategy.getQuestionFromList(questions: &self.questionsForGame)
            
            return (true, false)
            
        } else if answer == currentQuestion.whriteAnswer, self.questionsForGame.count == 0 {
            
            self.wrightAnswersCount.value += 1
            
            return (true, true)
            
        } else {
            
            return (false, true)
            
        }
    }
    

    
    init?(questions: [Question], shuffled: Bool) {
        
        self.questionSequenceStrategy = shuffled ? getRandomQuestionStrategy() : getNextBySequenceQuestionStrategy()
        
        self.questionsForGame = questions
        
        self.questionsInSession = questionsForGame.count
        
        guard questionsInSession != 0 else { return nil }
        
        self.currentQuestion = questionSequenceStrategy.getQuestionFromList(questions: &self.questionsForGame)
        
    }
    
    
}
