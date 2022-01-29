//
//  CovidInformationVCTheme.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 29.01.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation
import UIKit


enum CovidInformationTheme {
    case symptoms, spreadpaths, precautions
    
    var tintColor: UIColor {
        switch self {
        case .symptoms:
            return .systemPink
        case .spreadpaths:
            return .systemOrange
        case .precautions:
            return .systemBlue
        }
    }
    
    var advices: [CoronavirusInformationCellData] {
        let covidInfo = CoronavirusInfomation()
        switch self {
        case .symptoms:
            return covidInfo.symptoms
        case .spreadpaths:
            return covidInfo.spreadPaths
        case .precautions:
            return covidInfo.precautions
        }
    }
    
    var title: String {
        switch self {
        case .symptoms:
            return NSLocalizedString("SYMPTOMS", comment: "")
        case .spreadpaths:
            return NSLocalizedString("TRANSFER", comment: "")
        case .precautions:
            return NSLocalizedString("DEFENCE", comment: "")
        }
    }
    
}
