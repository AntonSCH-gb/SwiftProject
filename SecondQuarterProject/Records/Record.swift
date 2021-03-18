//
//  Record.swift
//  SecondQuarterProject
//
//  Created by Anton Scherbaev on 07.03.2021.
//

import Foundation

struct Record {
    var date: Date
    var score: Int
    var persent: Int
}

extension Record: Codable {}

typealias Memento = Data
