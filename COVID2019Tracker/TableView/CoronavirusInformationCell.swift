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
}

 struct CoronavirusInformationCellData {
    var informationText: String
    var informationImage: UIImage
}
