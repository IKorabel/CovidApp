//
//  CovidMainInfoTableViewCell.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 04.04.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//


import UIKit

class CovidMainInfoTableViewCell: UITableViewCell {
    @IBOutlet weak var infected: UILabel!
    @IBOutlet weak var died: UILabel!
    @IBOutlet weak var recovered: UILabel!
    
    func setMainInformation(globalStatistics: Global) {
        infected.text = "\(globalStatistics.totalConfirmed)"
        died.text = "\(globalStatistics.totalDeaths)"
        recovered.text = "\(globalStatistics.totalRecovered)"
    }
}
