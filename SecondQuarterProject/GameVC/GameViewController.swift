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
    
    @IBOutlet var answerButtonsArray: [UIButton]!
    
    @IBAction func anyAnswerButtonAction(_ sender: Any) {
        guard let button = sender as? UIButton else { return }
        
        answer(buttonLabelText: button.titleLabel?.text ?? "")
        
            }
    
    @IBAction func endGameButton(_ sender: Any) {
        let text = "Игра закончена, результат сохранен"
        showAlert(textForAlert: text, dismissGameVC: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setQuestionToVC()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        GameSingleton.shared.session.wrightAnswersCount.addObserver(self, options: [.new, .initial], closure: { [weak self] (wrightCount, _) in
            let text = "Вопрос \(wrightCount)/\(GameSingleton.shared.session.questionsInSession). Правильных ответов: \(wrightCount * 100 / (GameSingleton.shared.session.questionsInSession))%"
            self?.currentSessionStatus.text = text
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        GameSingleton.shared.session.wrightAnswersCount.removeObserver(self)
    }
    
    private func configureUI() {
        for button in answerButtonsArray {
            button.layer.cornerRadius = button.bounds.size.height / 2
        }
    }
    
    private func setQuestionToVC() {
        questionForScreen = GameSingleton.shared.session?.currentQuestion
        guard var questionForScreen = self.questionForScreen else { return }
        questionLabel.text = questionForScreen.question
        for button in answerButtonsArray {
            button.setTitle(questionForScreen.answers.remove(at: Int.random(in: 0..<questionForScreen.answers.count)), for: .normal)
        }
    }
    
    private func answer (buttonLabelText: String) {
        guard buttonLabelText != "", let nextStep = GameSingleton.shared.session?.checkAnswerAndGoNext(answer: buttonLabelText) else { return }
        switch nextStep {
        case .wrightAndContinue:
            
            let alertText = "Верно! У тебя уже \(GameSingleton.shared.session.wrightAnswersCount.value) баллов. Переходим к следующему"
            showAlert(textForAlert: alertText, dismissGameVC: false)
            setQuestionToVC()
            
        case .wrightAndFinish:
            
            let alertText = "Гениально! Ты победил и заработал \(GameSingleton.shared.session.wrightAnswersCount.value) баллов"
            showAlert(textForAlert: alertText, dismissGameVC: true)

        case .wrongAndFinish:
            
            let alertText = "Ответ не верный. Игра закончена со счетом \(GameSingleton.shared.session.wrightAnswersCount.value) баллов"
            showAlert(textForAlert: alertText, dismissGameVC: true)

        case .isNoQuestion:
            print("вопроса нет в переменной")
        }
    }

    private func showAlert (textForAlert: String, dismissGameVC: Bool) {
        
        let alert = UIAlertController(title: textForAlert, message: nil, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] _ in
            
            guard let self = self else { return }
            
            if dismissGameVC {
                self.endGameAndSaveRecord()
            }
        }))
        self.present(alert, animated: true)
    }

    private func endGameAndSaveRecord() {
        let date  = Date()
        let score = GameSingleton.shared.session.wrightAnswersCount.value
        let percent = score * 100 / GameSingleton.shared.session.questionsInSession
        let record = Record(date: date, score: score, persent: percent)
        self.dismiss(animated: true, completion: nil)
        self.gameVCDelegate?.didEndGame(with: record)
    }
    
}
