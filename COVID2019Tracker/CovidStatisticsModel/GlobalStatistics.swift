//
//  ConfirmedModel.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 01.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import Foundation
import CoreLocation

// MARK: - CovidStatistics
struct GlobalStatistics: Codable {
    let id: String
    let message: String
    let global: Global
    var countries: [Country]
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
