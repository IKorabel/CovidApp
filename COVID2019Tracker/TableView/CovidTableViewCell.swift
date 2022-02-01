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
    
    func setInformation(regionName: String, infectedAmount: String, deadAmount: String, recoveredAmount: String) {
        regionLabel.text = regionName
        infectedLabel.text = infectedAmount
        deadLabel.text = deadAmount
        recoveredLabel.text = recoveredAmount
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

