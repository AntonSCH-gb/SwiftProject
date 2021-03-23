//
//  StartViewController.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 19.02.2021.
//

import UIKit


class StartViewController: UIViewController{
    
    private let startGameSegueIdentifier = "StartSegue"
    private let showRecordsSegueIdentifier = "ScoreSegue"
    
    @IBAction func startGame(_ sender: UIButton) {
        let careTaker = MementoCaretaker()
        questions = careTaker.loadQuestions()
        guard let shuffled = GameSingleton.shared.settings[.ShuffleQuestion], let session = GameSession(questions: questions, shuffled: shuffled) else { return }
        //наличие вопросов в массиве проверяется инициализатором сессии
        
        GameSingleton.shared.session = session
        
        performSegue(withIdentifier: startGameSegueIdentifier, sender: self)
    }
    @IBAction func showScores(_ sender: UIButton) {
    }
    @IBOutlet weak var lastResultLabel: UILabel!
    
    @IBAction func eraseScoresButton(_ sender: Any) {
        GameSingleton.shared.clearRecords()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case startGameSegueIdentifier:
            guard let gameViewController = segue.destination as? GameViewController else { return }
            gameViewController.gameVCDelegate = self
        default: break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let lastResult = GameSingleton.shared.records.last {
            let text = "Последняя игра \(lastResult.date).\n Результат: \(lastResult.score) (\(lastResult.persent)%) правильных ответов"
            lastResultLabel.text = text
        } else {
            let text = "Пока нет результатов"
            lastResultLabel.text = text
        }

    }

}

extension StartViewController: GameViewControllerDelegate {
 
    func didEndGame(with score: Record) {
        let text = "Последняя игра \(score.date).\n Pезультат: \(score.score) (\(score.persent)%) правильных ответов"
        lastResultLabel.text = text
        GameSingleton.shared.addRecord(score)
        GameSingleton.shared.session = nil
    }
    
}
