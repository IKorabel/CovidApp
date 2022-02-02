//
//  CovidGuideInformationCell.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 02.02.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation
import UIKit

class CovidGuideInformationCell: UITableViewCell {
    @IBOutlet weak var coronavirusInfoLabel: UILabel!
    @IBOutlet weak var coronavirusInfoImage: UIImageView!
    
    func setInformation(information: CovidGuideInfo, tintColor: UIColor) {
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
