//
//  AddQuestionViewController.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 21.03.2021.
//

import UIKit

class AddQuestionViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var questionField: UITextView!
    
    @IBOutlet var AnswerFields: [UITextField]!
    
    @IBAction func addQuestionAction(_ sender: Any) {
        guard let inputResult = checkUserInput() else {
            let text = "Все поля должны быть заполнены. Проверьте и попробуйте еще раз."
            showAlert(textForAlert: text)
            return
        }
        let careTaker = MementoCaretaker()
        questions = careTaker.loadParameter(defaultValue: defaultQuestionsBase)
        questions += [inputResult]
        careTaker.saveParameter(parametr: questions)
        showAlert(textForAlert: "Вопрос сохранен.")
        clearTextFields()
    }
    
    @IBAction func deleteUserQuestions(_ sender: Any) {
        let caretaker = MementoCaretaker()
        caretaker.saveParameter(parametr: defaultQuestionsBase)

        let text = "Все сохраненные вопросы пользователя удалены. Остальсь стандартные."
        showAlert(textForAlert: text)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        AnswerFields.forEach{
            $0.delegate = self
        }
        questionField.layer.borderWidth = 1
        questionField.layer.borderColor = UIColor.systemGray5.cgColor
        questionField.layer.cornerRadius = 5
        
        let gestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(gestureRecogniser)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        }
    
    private func checkUserInput () -> Question? {
        
        var questionFromUser: Question?
        let questionText: String = questionField.text
        var answers: [String] = []
        
        for field in AnswerFields {
            if let text = field.text, text.count > 0 {
                answers.append(text)
            }
        }
        
        if questionText.count > 0 && answers.count == AnswerFields.count {
            questionFromUser = Question(question: questionText, whriteAnswer: answers.first!, answers: answers)
        }
        
        return questionFromUser
    }
    
    private func showAlert (textForAlert: String) {
        let alert = UIAlertController(title: textForAlert, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel))
        self.present(alert, animated: true)
    }

    private func clearTextFields() {
        let text = ""
        questionField.text = text
        AnswerFields.forEach{ $0.text = text }
    }
    
    @objc func hideKeyboard() {
            self.view.endEditing(true)
        }
    
    @objc func keyboardWasShown(notification: Notification) {
        
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillBeHidden() {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
    }
}

extension AddQuestionViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        for (number, field) in AnswerFields.enumerated() {
            if textField == field && number == AnswerFields.count - 1 {
                hideKeyboard()
            } else if textField == field {
                AnswerFields[number + 1].becomeFirstResponder()
            }
        }
        return true
    }
}
