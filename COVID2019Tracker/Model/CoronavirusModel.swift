//
//  ConfirmedModel.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 01.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import Foundation
import CoreLocation

var coronavirusInfo: Coronavirus?

class Coronavirus: Decodable {
    var confirmed: CasesInfo
    var deaths: CasesInfo
    var recovered: CasesInfo
}

struct CasesInfo: Decodable {
    var latest: Int
    var locations: [LocationData]
}

struct LocationData: Decodable {
    var coordinates: Coordinate
    var country: String
    var latest: Int
    var province: String
}

struct Coordinate: Decodable {
    var lat: String
    var long: String
}

struct History: Codable {
    let history: [String: String]
}

extension Array where Element == LocationData {
    
    func convertToComfortableArray() -> [LocationData] {
        let confirmedMerged = self
        let new = confirmedMerged.reduce([LocationData]()) { result, location in
         var temp = result
         guard let index = result.firstIndex(where: { $0.country == location.country }) else {
             temp.append(location)
             return temp }
         temp[index].latest = result[index].latest + location.latest
         return temp
        }
        return new.sorted { ($0.latest > $1.latest)}
    }
    
    
}

// MARK: - CovidStatistics
struct CovidStatistics: Codable {
    let id: String
    let message: String
    let global: Global
    let countries: [Country]
    let date: String
    
    enum CodingKeys: String, CodingKey {
            case id = "ID"
            case message = "Message"
            case global = "Global"
            case countries = "Countries"
            case date = "Date"
        }
}

// MARK: - Country
struct Country: Codable {
    let id: String
    let country: String
    let countryCode: String
    let slug: String
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    let date: String
    let premium: Premium
    var coordinates: CLLocationCoordinate2D?
    
    enum CodingKeys: String, CodingKey {
          case id = "ID"
          case country = "Country"
          case countryCode = "CountryCode"
          case slug = "Slug"
          case newConfirmed = "NewConfirmed"
          case totalConfirmed = "TotalConfirmed"
          case newDeaths = "NewDeaths"
          case totalDeaths = "TotalDeaths"
          case newRecovered = "NewRecovered"
          case totalRecovered = "TotalRecovered"
          case date = "Date"
          case premium = "Premium"
      }
}

// MARK: - Premium
struct Premium: Codable {
}

// MARK: - Global
struct Global: Codable {
    let newConfirmed: Int
    let totalConfirmed: Int
    let newDeaths: Int
    let totalDeaths: Int
    let newRecovered: Int
    let totalRecovered: Int
    let date: String
    
    enum CodingKeys: String, CodingKey {
            case newConfirmed = "NewConfirmed"
            case totalConfirmed = "TotalConfirmed"
            case newDeaths = "NewDeaths"
            case totalDeaths = "TotalDeaths"
            case newRecovered = "NewRecovered"
            case totalRecovered = "TotalRecovered"
            case date = "Date"
        }

}
