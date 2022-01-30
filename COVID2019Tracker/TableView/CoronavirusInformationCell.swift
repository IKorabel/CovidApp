//
//  CoronavirusInformationCell.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 04.04.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

class CoronavirusInfomationCell: UITableViewCell {
    @IBOutlet weak var coronavirusInfoLabel: UILabel!
    @IBOutlet weak var coronavirusInfoImage: UIImageView!
    
    func setInformation(information: CoronavirusInformationCellData, tintColor: UIColor) {
        coronavirusInfoImage.tintColor = tintColor
        coronavirusInfoLabel.text = information.informationText
        coronavirusInfoImage.image = information.informationImage
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCell()
    }
    
    func configureCell() {
        coronavirusInfoLabel.textColor = .label
        backgroundColor = .white
    }
}



 struct CoronavirusInformationCellData {
    var informationText: String
    var informationImage: UIImage
}
