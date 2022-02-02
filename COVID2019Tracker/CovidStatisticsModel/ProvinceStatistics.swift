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
struct ProvinceStatistics: Codable {
    let id: String
    let country: String
    let countryCode: String
    var province: String
    let city: String
    let cityCode: String
    let lat: String
    let lon: String
    let confirmed: Int
    let deaths: Int
    let recovered: Int
    let active: Int
    let date: String
    var dangerLevel: DangerLevel?

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

extension ProvinceStatistics {
    
    func convertCoordinatesToCLLocationCoordinate() -> CLLocationCoordinate2D? {
        guard !lat.isEmpty, !lon.isEmpty else { return nil }
        guard let latitude = Double(lat), let longitude = Double(lon) else { return nil }
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
}

extension Array where Element == ProvinceStatistics {
    
    ///  Defides the array into certain regions and assigns the newest data to each of them
    func splitByRegions() -> [ProvinceStatistics] {
        var countryStatisticsSplittedByProvinces = [ProvinceStatistics]()
        let allProvinces = self.map({$0.province}).uniqued()
        if allProvinces.isEmpty {
            guard let lastElement = self.last else { return self }
            countryStatisticsSplittedByProvinces.append(lastElement)
        } else {
            allProvinces.forEach { province in
                guard let filteredByRegion = self.filter({$0.province == province}).last else { return }
                countryStatisticsSplittedByProvinces.append(filteredByRegion)
            }
        }
        let categorizedSortedArray = countryStatisticsSplittedByProvinces.setDangerLevelForEveryRegion().sorted(by: {$0.confirmed > $1.confirmed})
        return categorizedSortedArray
    }
    
    /// Assigns each region a severity level based on the number of confirmed cases
    func setDangerLevelForEveryRegion() -> [ProvinceStatistics] {
        let confirmedCaseSum = self.map({$0.confirmed}).reduce(0, +)
        let confirmedCasesAverage = confirmedCaseSum / self.count
        self.forEach { statistic in
            var statistic = statistic
            statistic.dangerLevel = defineDangerLevel(casesAmount: statistic.confirmed, average: confirmedCasesAverage)
        }
        return self
    }
    
    /// Define the danger level  for region
    func defineDangerLevel(casesAmount: Int, average: Int) -> DangerLevel {
        if casesAmount > average {
            return .high
        } else if casesAmount <= average && casesAmount >= average / 2 {
            return .medium
        } else if casesAmount <= average && casesAmount < average / 2 {
            return .low
        }
        return .medium
    }
    
}

enum DangerLevel {
    case high,medium,low
    
    var color: UIColor {
        switch self {
        case .high:
            return .systemRed
        case .medium:
            return .systemYellow
        case .low:
            return .systemGreen
        }
    }
}
