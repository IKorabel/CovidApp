//
//  GeoServices.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 29.01.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation
import MapKit

class GeoServices {
    static let shared = GeoServices()
    
    private init() {}
    
    func findLocationForEveryCountry(countries: [Country], completion: @escaping (([Country]) -> Void)) {
        var inoutCountries = [Country]()
        let geocoder = CLGeocoder()
        countries.forEach { country in
            var country = country
            let countryName = country.country
            print(countryName)
            geocoder.geocodeAddressString(countryName) { placemark, error in
                guard let placemark = placemark?.first, error == nil else {
                    print(error?.localizedDescription)
                return }
                guard let location = placemark.location else { return }
                print("coordinate: \(location.coordinate)")
                country.coordinates = location.coordinate
                inoutCountries.append(country)
            }
        }
        print(inoutCountries.map({$0.coordinates}))
        completion(inoutCountries)
    }
    
}
