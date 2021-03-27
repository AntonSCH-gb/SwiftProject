//
//  AddQuestionViewController.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 21.03.2021.
//

import UIKit

class AddQuestionViewController: UIViewController {

    @IBOutlet weak var questionField: UITextView!
    
    @IBOutlet weak var answerField1: UITextField!
    
    @IBOutlet weak var answerField2: UITextField!
    
    @IBOutlet weak var answerField3: UITextField!
    
    @IBOutlet weak var answerField4: UITextField!
    
    @IBAction func addQuestionAction(_ sender: Any) {
        guard let inputResult = checkUserInput() else {
            let text = "Все поля должны быть заполнены. Проверьте и попробуйте еще раз."
            showAlert(textForAlert: text, dismissVC: false)
            return
        }
        let caretaker = MementoCaretaker()
        questions = caretaker.loadQuestions()
        questions += [inputResult]
        caretaker.saveQuestions(questions: questions)
        showAlert(textForAlert: "Вопрос сохранен.", dismissVC: true)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteUserQuestions(_ sender: Any) {
        let caretaker = MementoCaretaker()
        caretaker.saveQuestions(questions: defaultQuestionsBase)
        let text = "Все сохраненные вопросы пользователя удалены. Остальсь стандартные."
        showAlert(textForAlert: text, dismissVC: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionField.layer.borderWidth = 1
        questionField.layer.borderColor = UIColor.systemGray5.cgColor
        questionField.layer.cornerRadius = 5
        
        // Do any additional setup after loading the view.
    }
    
    func checkUserInput () -> Question? {
        var questionFromUser: Question?
        if let question = questionField.text,
           let wrightAnswer = answerField1.text,
           let wrongAnswer1 = answerField1.text,
           let wrongAnswer2 = answerField2.text,
           let wrongAnswer3 = answerField3.text,
           question.count != 0,
           wrightAnswer.count != 0,
           wrongAnswer1.count != 0,
           wrongAnswer2.count != 0,
           wrongAnswer2.count != 0 {
            questionFromUser = Question(question: question, whriteAnswer: wrightAnswer, answers: [wrightAnswer, wrongAnswer1, wrongAnswer2, wrongAnswer3])
        }
        return questionFromUser
        
    }
    
    func showAlert (textForAlert: String, dismissVC: Bool) {
        let alert = UIAlertController(title: textForAlert, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in
            if dismissVC {
                self.dismiss(animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true)
    }

}
