//
//  ShuffleQuestionStrategy.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 21.03.2021.
//

import Foundation

protocol ShuffleQuestionStrategy {
    func getQuestionFromList (questions: inout [Question])  -> Question?
}

final class getRandomQuestionStrategy: ShuffleQuestionStrategy {
    func getQuestionFromList (questions: inout [Question]) -> Question? {
        let questionsCount = questions.count
        guard questionsCount != 0 else { return nil }
        return questions.remove(at: Int.random(in: 0..<questionsCount))
        
    }
}

final class getNextBySequenceQuestionStrategy: ShuffleQuestionStrategy {
    func getQuestionFromList (questions: inout [Question]) -> Question? {
        let questionsCount = questions.count
        guard questionsCount != 0 else { return nil }
        return questions.remove(at: 0)
    }
}
