//
//  CoronavirusInfomation.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 04.04.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

class CoronavirusInfomation {
    var symptoms = [CoronavirusInformationCellData(informationText: NSLocalizedString("laboredBreathing", comment: ""),                        informationImage: UIImage(systemName: "lungs.fill")!)
    ,CoronavirusInformationCellData(informationText: NSLocalizedString("Fever", comment: ""), informationImage: UIImage(systemName: "thermometer")!),
                    CoronavirusInformationCellData(informationText: NSLocalizedString("Dry cough", comment: ""), informationImage: UIImage(named: "icons8-coughing-60")!)]
    
    var spreadPaths = [CoronavirusInformationCellData(informationText: NSLocalizedString("Sneezing", comment: ""),
                                                      informationImage: UIImage(named: "icons8-чихать-60")!),
    CoronavirusInformationCellData(informationText: NSLocalizedString("Cough", comment: ""),
                                   informationImage: UIImage(named: "icons8-coughing-61")!),
    CoronavirusInformationCellData(informationText: NSLocalizedString("DirtyHands", comment: ""),
                                   informationImage: UIImage(systemName: "hand.raised.fill")!),
    CoronavirusInformationCellData(informationText: NSLocalizedString("Kisses", comment: ""),
                                   informationImage: UIImage(named: "icons8-kiss-_-*-60")!),
    CoronavirusInformationCellData(informationText: NSLocalizedString("Snot", comment: ""),
                                   informationImage: UIImage(named: "icons8-snot-64")!)]
    
    var precautions = [
    CoronavirusInformationCellData(informationText: NSLocalizedString("stayHome", comment: ""),
                                   informationImage: UIImage(systemName: "house.fill")!),
    CoronavirusInformationCellData(informationText: NSLocalizedString("WearFFP3", comment: ""),
                                   informationImage: UIImage(systemName: "facemask.fill")!),
                       
    CoronavirusInformationCellData(informationText: NSLocalizedString("WashHands", comment: ""),
                                   informationImage: UIImage(systemName: "hands.sparkles.fill")!),
    CoronavirusInformationCellData(informationText: NSLocalizedString("DoNotTouchTheFace", comment: ""),
                                   informationImage: UIImage(systemName: "hand.raised.slash.fill")!),
    CoronavirusInformationCellData(informationText: NSLocalizedString("WipeSmartphone", comment: ""),
                                   informationImage:   UIImage(systemName: "iphone")!)]
}
