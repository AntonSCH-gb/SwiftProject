//
//  GameViewController.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 19.02.2021.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func didEndGame(with score: Record)
}

class GameViewController: UIViewController {
    
    weak var gameVCDelegate: GameViewControllerDelegate?
    
    var questionForScreen: Question?
    
    @IBOutlet var currentSessionStatus: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var firstButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var thirdButton: UIButton!
    @IBOutlet weak var fourthButton: UIButton!
    
    
    
    @IBAction func firstAnswerButton(_ sender: UIButton) {
        answer(buttonLabelText: firstButton.titleLabel?.text ?? "")
    }
    @IBAction func secondAnswerButton(_ sender: UIButton) {
        answer(buttonLabelText: secondButton.titleLabel?.text ?? "")
    }
    @IBAction func thirdAnswerButton(_ sender: UIButton) {
        answer(buttonLabelText: thirdButton.titleLabel?.text ?? "")
    }
    @IBAction func fourthAnswerButton(_ sender: UIButton) {
        answer(buttonLabelText: fourthButton.titleLabel?.text ?? "")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GameSingleton.shared.session!.wrightAnswersCount.addObserver(self, options: [.new, .initial], closure: { [weak self] (wrightCount, _) in
            let text = "Вопрос \(wrightCount)/\(GameSingleton.shared.session!.questionsInSession). Правильных ответов: \(wrightCount * 100 / (GameSingleton.shared.session!.questionsInSession))%"
            self?.currentSessionStatus.text = text
        })
        setQuestionToVC()
    }
    
    
    
    func setQuestionToVC() {
        questionForScreen = GameSingleton.shared.session?.currentQuestion
        guard var questionForScreen = self.questionForScreen else { return }
        questionLabel.text = questionForScreen.question
        firstButton.setTitle(questionForScreen.answers.remove(at: Int.random(in: 0..<questionForScreen.answers.count)), for: .normal)
        secondButton.setTitle(questionForScreen.answers.remove(at: Int.random(in: 0..<questionForScreen.answers.count)), for: .normal)
        thirdButton.setTitle(questionForScreen.answers.remove(at: Int.random(in: 0..<questionForScreen.answers.count)), for: .normal)
        fourthButton.setTitle(questionForScreen.answers.remove(at: Int.random(in: 0..<questionForScreen.answers.count)), for: .normal)
        
    }
    
    func answer (buttonLabelText: String) {
        guard buttonLabelText != "", let nextStep = GameSingleton.shared.session?.checkAnswerAndGoNext(answer: buttonLabelText) else { return }
        switch nextStep {
        case (true, false):
            
            let alertText = "Верно! У тебя уже \(GameSingleton.shared.session!.wrightAnswersCount.value) баллов. Переходим к следующему"
            
            showAlert(textForAlert: alertText, dismissGameVC: false)
            
            setQuestionToVC()
            
        case (true, true):
            
            let alertText = "Гениально! Ты победил и заработал \(GameSingleton.shared.session!.wrightAnswersCount.value) баллов"
            showAlert(textForAlert: alertText, dismissGameVC: true)

        case (false, true):
            
            let alertText = "Ответ не верный. Игра закончена со счетом \(GameSingleton.shared.session!.wrightAnswersCount.value) баллов"
            
            showAlert(textForAlert: alertText, dismissGameVC: true)

        default:
            print("текущего вопроса нет в переменной")
        }
    }

    func showAlert (textForAlert: String, dismissGameVC: Bool) {
        let alert = UIAlertController(title: textForAlert, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: {_ in
            if dismissGameVC {
                let date  = Date()
                let score = GameSingleton.shared.session!.wrightAnswersCount.value
                let percent = score / GameSingleton.shared.session!.questionsInSession * 10
                let record = Record(date: date, score: score, persent: percent)
                self.gameVCDelegate?.didEndGame(with: record)
                self.dismiss(animated: true, completion: nil)
            }
        }))
        self.present(alert, animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
