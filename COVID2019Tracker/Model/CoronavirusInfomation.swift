//
//  CoronavirusInfomation.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 04.04.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

class CoronavirusInfomation {
    var symptoms = [CoronavirusInformationCellData(informationText: NSLocalizedString("laboredBreathing", comment: ""),            informationImage: #imageLiteral(resourceName: "lung 1"))
    ,CoronavirusInformationCellData(informationText: NSLocalizedString("Fever", comment: ""), informationImage: #imageLiteral(resourceName: "heat 1")),
     CoronavirusInformationCellData(informationText: NSLocalizedString("Dry cough", comment: ""), informationImage: #imageLiteral(resourceName: "cough 1"))]
    
    var spreadPaths = [CoronavirusInformationCellData(informationText: NSLocalizedString("Sneezing", comment: ""), informationImage: #imageLiteral(resourceName: "cough-3 1")),
    CoronavirusInformationCellData(informationText: NSLocalizedString("Cough", comment: ""), informationImage: #imageLiteral(resourceName: "cough 1")),
    CoronavirusInformationCellData(informationText: NSLocalizedString("DirtyHands", comment: ""), informationImage: #imageLiteral(resourceName: "Group-1")),
    CoronavirusInformationCellData(informationText: NSLocalizedString("Kisses", comment: ""), informationImage: #imageLiteral(resourceName: "kiss 1")),
    CoronavirusInformationCellData(informationText: NSLocalizedString("Snot", comment: ""), informationImage: #imageLiteral(resourceName: "cough-2 1"))]
    
    var precautions = [CoronavirusInformationCellData(informationText: NSLocalizedString("stayHome", comment: ""), informationImage: #imageLiteral(resourceName: "living 1")),
    CoronavirusInformationCellData(informationText: NSLocalizedString("WearFFP3", comment: ""), informationImage: #imageLiteral(resourceName: "medical-mask 1")),
    CoronavirusInformationCellData(informationText: NSLocalizedString("WashHands", comment: ""), informationImage: #imageLiteral(resourceName: "hand-wash 1")),
    CoronavirusInformationCellData(informationText: NSLocalizedString("DoNotTouchTheFace", comment: ""), informationImage: #imageLiteral(resourceName: "Group 6")),
    CoronavirusInformationCellData(informationText: NSLocalizedString("WipeSmartphone", comment: ""), informationImage: UIImage(named: "Group 7")!)]
}
