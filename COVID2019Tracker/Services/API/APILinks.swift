//
//  APILinkns.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 02.02.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation

extension APIService {

/// With APILinks Enum we can select the API's link from which we want to get the necessary json dats
enum APILinks {
    case summaryStatisticsLink
    case countryLiveStatisticsLink(countryCode: String)
    
    var link: String {
        switch self {
        case .summaryStatisticsLink:
            return "https://api.covid19api.com/summary"
        case .countryLiveStatisticsLink(let countryCode):
            return "https://api.covid19api.com/live/country/\(countryCode)"
        }
    }
}
    
}
