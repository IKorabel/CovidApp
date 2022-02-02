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
        setInformation(regionName: country.country,
                       numberOfDead: country.totalDeaths.formattedWithSeparator,
                       numberOfInfected: country.totalConfirmed.formattedWithSeparator,
                       numberOfRecovered: country.totalRecovered.formattedWithSeparator)
    }
    
    func setProvince(province: ProvinceStatistics?) {
        guard let province = province else { return }
        let provinceName = province.province.isEmpty ? province.country : province.province
        setInformation(regionName: provinceName,
                       numberOfDead: province.deaths.formattedWithSeparator,
                       numberOfInfected: province.confirmed.formattedWithSeparator,
                       numberOfRecovered: province.recovered.formattedWithSeparator)
    }
    
    func setInformation(regionName: String, numberOfDead: String, numberOfInfected: String, numberOfRecovered: String) {
        countryNameLabel.text = regionName
        numberOfDeadLabel.text = numberOfDead
        numberOfInfectedLabel.text = numberOfInfected
        numberOfRecoveredLabel.text = numberOfRecovered
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
