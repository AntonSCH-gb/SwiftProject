//
//  ShuffleSettingCell.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 18.03.2021.
//

import UIKit

class SettingCell: UITableViewCell {

    static let reuseIdentifier = "SettingCellWithSwitch"
    
    
    var cellSetting: GamePlaySettings!
    
    @IBOutlet weak var settingLabel: UILabel!
    
    @IBOutlet weak var switcher: UISwitch!
    
    @IBAction func switchAction(_ sender: Any) {
        switch switcher.isOn {
        case true:
            switcher.setOn(true, animated: true)
            GameSingleton.shared.changeSettingState(settingCase: cellSetting)
        case false:
            switcher.setOn(false, animated: true)
            GameSingleton.shared.changeSettingState(settingCase: cellSetting)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setCell (setting name: GamePlaySettings) {
        guard let settingState = GameSingleton.shared.settings[name] else {
            settingLabel.text = "Настройка не доступна"
            switcher.isOn = false
            switcher.isUserInteractionEnabled = false
            return
        }
        cellSetting = name
        switch name {
        case .shuffleQuestion:
            settingLabel.text = "Перемешать вопросы"
            switcher.isOn = settingState
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
