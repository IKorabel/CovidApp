//
//  CountriesStatisticsCollectionViewCell.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 30.01.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import UIKit

class CountriesStatisticsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var numberOfDeadLabel: UILabel!
    @IBOutlet weak var numberOfInfectedLabel: UILabel!
    @IBOutlet weak var numberOfRecoveredLabel: UILabel!
    
    func setCountry(country: Country?) {
        guard let country = country else { return }
        countryNameLabel.text = country.country
        numberOfDeadLabel.text = "\(country.totalDeaths)"
        numberOfInfectedLabel.text = "\(country.totalConfirmed)"
        numberOfRecoveredLabel.text = "\(country.totalRecovered)"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShape()
    }
    
    func setShape() {
        layer.cornerRadius = 20
        backgroundColor = .white
    }
    
}
