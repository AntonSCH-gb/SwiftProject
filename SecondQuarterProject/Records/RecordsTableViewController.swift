//
//  RecordsTableViewController.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 19.02.2021.
//

import UIKit

class RecordsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

   

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GameSingleton.shared.records.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RecordsTableViewCell.reuseIdentifier, for: indexPath) as! RecordsTableViewCell
        cell.isUserInteractionEnabled = false

        let record = GameSingleton.shared.records[indexPath.row]
        
        cell.dateLabel.text = record.date.description
        cell.scoreLabel.text = "score: \(record.score) (\(record.persent)%)"
        return cell
    }


}
