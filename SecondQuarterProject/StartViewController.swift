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
        GameSingleton.shared.session = GameSession(questions: questions)
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
            lastResultLabel.text = "Последняя игра \(lastResult.date).\n Pезультат: \(lastResult.score) очков и \(lastResult.persent)% правильных ответов"
        } else {
            lastResultLabel.text = "Пока нет результатов"
        }

    }

}

extension StartViewController: GameViewControllerDelegate {
 
    func didEndGame(with score: Record) {
        lastResultLabel.text = "Последняя игра \(score.date).\n Pезультат: \(score.score) очков и \(score.persent)% правильных ответов"
        GameSingleton.shared.addRecord(score)
        GameSingleton.shared.session = nil
    }
    
}
