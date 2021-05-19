//
//  SettingsTableViewController.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 18.03.2021.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    private let settingsForSetup = Array(GameSingleton.shared.settings.keys)
    private let settingsForTransition = Array(settingsWithTransition.keys)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsForSetup.count + settingsWithTransition.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell
        
        if indexPath.row < settingsForSetup.count,
           let gamePlaySettingCell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as? SettingCell {
            
            gamePlaySettingCell.setCell(setting: settingsForSetup[indexPath.row])
            cell = gamePlaySettingCell
            
        } else if (settingsForSetup.count..<settingsForSetup.count + settingsForTransition.count).contains(indexPath.row),
           let transitionCell = tableView.dequeueReusableCell(withIdentifier: SettingWithTransitionCell.reuseIdentifier, for: indexPath) as? SettingWithTransitionCell{
            
            transitionCell.setCell(setting: settingsForTransition[indexPath.row - settingsForSetup.count])
            cell = transitionCell
            
        } else {
            cell = UITableViewCell()
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? SettingWithTransitionCell {
            switch cell.cellSetting {
            case .addUserQuestion:
                guard let vc = storyboard?.instantiateViewController(withIdentifier: "AddQuestionViewController") else { return }
                self.navigationController?.pushViewController(vc, animated: true)
            case .none:
                return
            }
            
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
