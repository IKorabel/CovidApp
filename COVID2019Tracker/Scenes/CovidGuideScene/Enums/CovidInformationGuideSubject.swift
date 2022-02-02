//
//  CovidInformationVCTheme.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 29.01.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation
import UIKit

/// With this  Enum we can select thr subject which we want to user basically on CoviidGuideVC
enum CovidInformationGuideSubject {
    case symptoms, spreadpaths, precautions
    
    /// ThemeColor of  CovidGuideVC
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
    /// Guide information attached for a specific topic
    var advices: [CovidGuideInfo] {
        switch self {
        case .symptoms:
            return CovidGuideInformationStorage.symptoms
        case .spreadpaths:
            return CovidGuideInformationStorage.spreadPaths
        case .precautions:
            return CovidGuideInformationStorage.precautions
        }
    }
    
    /// Title attached for a specific topic
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
