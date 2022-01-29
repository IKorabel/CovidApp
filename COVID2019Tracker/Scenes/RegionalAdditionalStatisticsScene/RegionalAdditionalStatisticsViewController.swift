//
//  CoronavirusStatisticDetailControllerViewController.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 09.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit
import MapKit

class RegionalAdditionalStatisticsViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var coronavirusMap: MKMapView!
    @IBOutlet weak var CountryProvinceTableView: UITableView!
    
    var geoServices = GeoServices.shared
    var provinceData: ([LocationData?],[LocationData?],[LocationData?])?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSettings()
        navigationBar.title = provinceData?.0[0]?.country
        geoServices.showPlaces(map: coronavirusMap, provinceData: provinceData)
        geoServices.mapSettings(map: coronavirusMap)
    }

}

//MARK: TableView
extension RegionalAdditionalStatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provinceData!.0.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "provinceCell") as! CoronavirusProvinceMapStatiticsTableViewCell
        cell.backgroundColor = UIColor.black
        if provinceData!.0[indexPath.row]!.province == "" {
            cell.provinceName.text = provinceData!.0[indexPath.row]?.country
        } else {
            cell.provinceName.text = provinceData!.0[indexPath.row]?.province
        }
        cell.infected.text = "\(provinceData!.0[indexPath.row]!.latest)"
        cell.died.text =  "\(provinceData!.1[indexPath.row]!.latest)"
        cell.recovered.text =  "\(provinceData!.2[indexPath.row]!.latest)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        geoServices.showLocation(coronavirusMap: coronavirusMap, place: provinceData?.0[indexPath.row])
    }
    
    func tableViewSettings() {
        CountryProvinceTableView.tableFooterView = UIView()
        CountryProvinceTableView.backgroundColor = UIColor.black
    }
    
}

//MapViewDelegate
extension RegionalAdditionalStatisticsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var coronavirusAnnotationView = coronavirusMap.dequeueReusableAnnotationView(withIdentifier: "coronavirusAnnotation")
        coronavirusAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "coronavirusAnnotation")
        coronavirusAnnotationView?.canShowCallout = true
        coronavirusAnnotationView?.image = UIImage(named: "PinClipart.com_video-editing-clip-art_2180392 — копия")
        return coronavirusAnnotationView
     }
}

