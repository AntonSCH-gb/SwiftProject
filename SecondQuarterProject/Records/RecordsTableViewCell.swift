//
//  RecordsTableViewCell.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 19.02.2021.
//

import UIKit

class RecordsTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "RecordCell"

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var scoreLabel: UILabel!
    
}
