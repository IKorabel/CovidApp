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
    
    /// Define coordinate for every country by geocoding. 
    func findLocationForEveryCountry(countries: [Country], completion: @escaping (([Country]) -> Void)) {
        var inoutCountries = [Country]()
        let geocoder = CLGeocoder()
        countries.forEach { country in
            var country = country
            let countryName = country.country
            print(countryName)
            geocoder.geocodeAddressString(countryName) { placemark, error in
                guard let placemark = placemark?.first, error == nil else { return }
                guard let location = placemark.location else { return }
                country.coordinates = location.coordinate
                inoutCountries.append(country)
            }
        }
        print(inoutCountries.map({$0.coordinates}))
        completion(inoutCountries)
    }
    
    /// Create and show pin for every  province
    public func showPlaces(map: MKMapView,provinceData: [ProvinceStatistics]?) {
        guard let provinceData = provinceData else { return }
        provinceData.forEach({ showLocation(coronavirusMap: map, coordinate: $0.convertCoordinatesToCLLocationCoordinate())})
    }
    
    /// Create and show annottation for every coordinste
    public func showLocation(coronavirusMap: MKMapView, coordinate: CLLocationCoordinate2D?) {
           guard let coordinate = coordinate else { return }
           let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
           let region = MKCoordinateRegion(center: coordinate, span: span)
           let annotation = MKPointAnnotation()
           annotation.coordinate = coordinate
           annotation.title = ""
           annotation.subtitle = "Infected: 0"
           coronavirusMap.setRegion(region, animated: true)
           coronavirusMap.addAnnotation(annotation)
           coronavirusMap.selectAnnotation(annotation, animated: true)
       }
    
}
