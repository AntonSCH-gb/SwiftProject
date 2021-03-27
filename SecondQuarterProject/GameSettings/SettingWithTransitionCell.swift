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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if let cellSetting = cellSetting, selected {
            switch cellSetting {
            case .addUserQuestion:
                self.window?.rootViewController?.dismiss(animated: true, completion: {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let addQuestionViewController = storyboard.instantiateViewController(withIdentifier: "AddQuestionViewController") as! AddQuestionViewController
                    let currentViewController = UIApplication.shared.windows.first!.rootViewController
                    addQuestionViewController.modalPresentationStyle = .fullScreen
                    currentViewController?.present(addQuestionViewController, animated: true, completion: nil)
                })
        }

    }

}
}
