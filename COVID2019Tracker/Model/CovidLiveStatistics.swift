//
//  CovidLiveStatistics.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 29.01.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation

// MARK: - CovidLiveStatistic
struct CovidLiveStatistic: Codable {
    let id: String
    let country: String
    let countryCode: String
    let province: String
    let city: String
    let cityCode: String
    let lat: String
    let lon: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    let date: Date

    enum CodingKeys: String, CodingKey {
        case id
        case country
        case countryCode
        case province
        case city
        case cityCode
        case lat
        case lon
        case confirmed
        case deaths
        case recovered
        case active
        case date
    }
}
