//
//  CovidLiveStatistics.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 29.01.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation
import MapKit

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
    let date: String

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case country = "Country"
        case countryCode = "CountryCode"
        case province = "Province"
        case city = "City"
        case cityCode = "CityCode"
        case lat = "Lat"
        case lon = "Lon"
        case confirmed = "Confirmed"
        case deaths = "Deaths"
        case recovered = "Recovered"
        case active = "Active"
        case date = "Date"
    }
}

extension CovidLiveStatistic {
    
    func convertCoordinatesToCLLocationCoordinate() -> CLLocationCoordinate2D? {
        guard !lat.isEmpty, !lon.isEmpty else { return nil }
        guard let latitude = Double(lat), let longitude = Double(lon) else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}
