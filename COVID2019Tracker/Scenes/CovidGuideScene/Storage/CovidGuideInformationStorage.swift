//
//  CoronavirusInfomation.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 04.04.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

struct CovidGuideInformationStorage {
    
    static var symptoms: [CovidGuideInfo] {
        return [
        CovidGuideInfo(informationText: NSLocalizedString("laboredBreathing", comment: ""),informationImage: UIImage(systemName: "lungs.fill")!),
         CovidGuideInfo(informationText: NSLocalizedString("Fever", comment: ""), informationImage: UIImage(systemName: "thermometer")!),
         CovidGuideInfo(informationText: NSLocalizedString("Dry cough", comment: ""), informationImage: UIImage(named: "icons8-coughing-60")!)]
    }
    
    static var spreadPaths: [CovidGuideInfo] {
        return [
        CovidGuideInfo(informationText: NSLocalizedString("Sneezing", comment: ""),
                                       informationImage: UIImage(named: "icons8-чихать-60")!),
        CovidGuideInfo(informationText: NSLocalizedString("Cough", comment: ""),
                                       informationImage: UIImage(named: "icons8-coughing-61")!),
        CovidGuideInfo(informationText: NSLocalizedString("DirtyHands", comment: ""),
                                       informationImage: UIImage(systemName: "hand.raised.fill")!),
        CovidGuideInfo(informationText: NSLocalizedString("Kisses", comment: ""),
                                       informationImage: UIImage(named: "icons8-kiss-_-*-60")!),
        CovidGuideInfo(informationText: NSLocalizedString("Snot", comment: ""),
                                       informationImage: UIImage(named: "icons8-snot-64")!)]
    }
    
    static var precautions: [CovidGuideInfo] {
        return [
        CovidGuideInfo(informationText: NSLocalizedString("stayHome", comment: ""),
                                       informationImage: UIImage(systemName: "house.fill")!),
        CovidGuideInfo(informationText: NSLocalizedString("WearFFP3", comment: ""),
                                       informationImage: UIImage(systemName: "facemask.fill")!),
        CovidGuideInfo(informationText: NSLocalizedString("WashHands", comment: ""),
                                       informationImage: UIImage(systemName: "hands.sparkles.fill")!),
        CovidGuideInfo(informationText: NSLocalizedString("DoNotTouchTheFace", comment: ""),
                                       informationImage: UIImage(systemName: "hand.raised.slash.fill")!),
        CovidGuideInfo(informationText: NSLocalizedString("WipeSmartphone", comment: ""),
                                       informationImage:   UIImage(systemName: "iphone")!)]
    }
    
}
