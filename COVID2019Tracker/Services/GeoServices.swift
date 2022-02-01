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
                guard let placemark = placemark?.first, error == nil else { return }
                guard let location = placemark.location else { return }
                print("coordinate: \(location.coordinate)")
                country.coordinates = location.coordinate
                inoutCountries.append(country)
            }
        }
        print(inoutCountries.map({$0.coordinates}))
        completion(inoutCountries)
    }
    
    func mapSettings(map: MKMapView) {
        if #available(iOS 13.0, *) {
            map.overrideUserInterfaceStyle = .dark
        }
    }
    
    func showPlaces(map: MKMapView,provinceData: ([LocationData?],[LocationData?],[LocationData?])?) {
        guard let provinceData = provinceData else { return }
        //for place in provinceData.0 { showLocation(coronavirusMap: map, place: place) }
    }
    
    func showLocation(coronavirusMap: MKMapView, coordinate: CLLocationCoordinate2D?) {
           guard let coordinate = coordinate else { return }
           let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
           let region = MKCoordinateRegion(center: coordinate, span: span)
           let annotation = MKPointAnnotation()
           annotation.coordinate = coordinate
          // annotation.title = place.province
        //   annotation.subtitle = "Infected: \(place.latest)"
           coronavirusMap.setRegion(region, animated: true)
           coronavirusMap.addAnnotation(annotation)
           coronavirusMap.selectAnnotation(annotation, animated: true)
       }
    
}
