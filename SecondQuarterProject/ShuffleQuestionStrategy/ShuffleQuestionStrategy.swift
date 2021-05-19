//
//  ShuffleQuestionStrategy.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 21.03.2021.
//

import Foundation

protocol ShuffleQuestionStrategy {
//    func getQuestionFromList (questions: inout [Question])  -> Question?
    func fetchQuestions () -> [Question]
}

final class ShuffledQuestions: ShuffleQuestionStrategy {
    func fetchQuestions() -> [Question] {
        return questions.shuffled()
    }
}

final class UnShuffledQuestions: ShuffleQuestionStrategy {
    func fetchQuestions() -> [Question] {
        return questions
    }
}
