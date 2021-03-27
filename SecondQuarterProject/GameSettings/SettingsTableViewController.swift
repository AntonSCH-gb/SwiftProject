//
//  SettingsTableViewController.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 18.03.2021.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var settingsForSetup: [GamePlaySettings]!
    var settingsForTransition: [SettingsWithTransition]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        settingsForSetup = Array(GameSingleton.shared.settings.keys)
        settingsForTransition = Array(settingsWithTransition.keys)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Настройки"
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsForSetup.count + settingsWithTransition.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: UITableViewCell!
        
        if indexPath.row < settingsForSetup.count {
            
            let gamePlaySettingCell = tableView.dequeueReusableCell(withIdentifier: SettingCell.reuseIdentifier, for: indexPath) as! SettingCell
            
            gamePlaySettingCell.setCell(setting: settingsForSetup[indexPath.row])
            
            
            cell = gamePlaySettingCell
            
        } else {
            
            
            
            let transitionCell = tableView.dequeueReusableCell(withIdentifier: SettingWithTransitionCell.reuseIdentifier, for: indexPath) as! SettingWithTransitionCell
            
            transitionCell.setCell(setting: settingsForTransition[indexPath.row - settingsForSetup.count])
            
            
            cell = transitionCell
        }

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
