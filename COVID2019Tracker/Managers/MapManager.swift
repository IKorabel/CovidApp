//
//  MapManager.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 04.04.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit
import MapKit

class MapManager {
    
    func mapSettings(map: MKMapView) {
        if #available(iOS 13.0, *) {
            map.overrideUserInterfaceStyle = .dark
        }
    }
    
    func showPlaces(map: MKMapView,provinceData: ([LocationData?],[LocationData?],[LocationData?])?) {
        guard let provinceData = provinceData else { return }
        for place in provinceData.0 { showLocation(coronavirusMap: map, place: place) }
    }
    
    func showLocation(coronavirusMap: MKMapView, place: LocationData?) {
           guard let place = place else { return }
           let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
           let coordinates = CLLocationCoordinate2D(latitude: Double(place.coordinates.lat) ?? 0,
                                                    longitude: Double(place.coordinates.long) ?? 0)
           let region = MKCoordinateRegion(center: coordinates, span: span)
           let annotation = MKPointAnnotation()
           annotation.coordinate = coordinates
           annotation.title = place.province
           annotation.subtitle = "Infected: \(place.latest)"
           coronavirusMap.setRegion(region, animated: true)
           coronavirusMap.addAnnotation(annotation)
           coronavirusMap.selectAnnotation(annotation, animated: true)
       }
    
}
