//
//  ConfirmedModel.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 01.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import Foundation

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

