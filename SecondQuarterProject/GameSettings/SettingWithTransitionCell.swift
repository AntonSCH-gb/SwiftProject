//
//  SettingWithTransitionCell.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 21.03.2021.
//

import UIKit

class SettingWithTransitionCell: UITableViewCell {
    
    static let reuseIdentifier: String = "SettingCellWithTransition"
    
    var cellSetting: SettingsWithTransition!

    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setCell (setting name: SettingsWithTransition) {
        cellSetting = name
        cellLabel.text = settingsWithTransition[name]
    }
    
}
