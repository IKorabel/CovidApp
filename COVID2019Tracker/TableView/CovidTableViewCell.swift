//
//  CovidTableViewCell.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 02.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

class CovidTableViewCell: UITableViewCell {
    @IBOutlet weak var regionLabel: UILabel!
    @IBOutlet weak var infectedLabel: UILabel!
    @IBOutlet weak var deadLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    func setInformation(country: Country?) {
        guard let country = country else { return }
        regionLabel.text = country.country
        infectedLabel.text = "\(country.totalConfirmed)"
        deadLabel.text = "\(country.totalDeaths)"
        recoveredLabel.text = "\(country.totalRecovered)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShape()
    }
    
    func setShape() {
        setSeparator()
    }
    
    func setSeparator() {
        separatorInset = UIEdgeInsets(top: 0, left: bounds.size.width, bottom: 0, right: 0)
    }
}

