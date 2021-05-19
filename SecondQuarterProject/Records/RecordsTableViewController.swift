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
        let cell = UITableViewCell(style: .value1, reuseIdentifier: "RecCell")
        
        let record = GameSingleton.shared.records[indexPath.row]
        
        cell.textLabel?.text = GameSingleton.shared.dateFormatter.string(from: record.date)
        cell.detailTextLabel?.text = "score: \(record.score) (\(record.persent)%)"
        
        return cell
    }
}
