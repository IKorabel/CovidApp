//
//  CoronavirusStatisticDetailControllerViewController.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 09.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit
import MapKit

class CoronavirusStatisticDetailControllerViewController: UIViewController {
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var coronavirusMap: MKMapView!
    @IBOutlet weak var CountryProvinceTableView: UITableView!
    
    var provinceData: ([LocationData?],[LocationData?],[LocationData?])?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coronavirusMap.delegate = self
        self.coronavirusMap.showsUserLocation = true
        if #available(iOS 13.0, *) {
        coronavirusMap.overrideUserInterfaceStyle = .dark
        }
        CountryProvinceTableView.tableFooterView = UIView()
        CountryProvinceTableView.backgroundColor = UIColor.black
        navigationBar.title = provinceData?.0[0]?.country
        showPlaces()
        // Do any additional setup after loading the view.
    }
    
    func showPlaces() {
        guard provinceData != nil else { return }
        for place in provinceData!.0 {
            showLocation(place: place)
        }
    }
    
    func showLocation(place: LocationData?) {
        let span = MKCoordinateSpan(latitudeDelta: 50, longitudeDelta: 50)
        let coordinates = CLLocationCoordinate2D(latitude: Double((place?.coordinates.lat)!)!, longitude: Double((place?.coordinates.long)!)!)
        let region = MKCoordinateRegion(center: coordinates, span: span)
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinates
        annotation.title = place?.province
        annotation.subtitle = "Infected: \(place!.latest)"
        coronavirusMap.setRegion(region, animated: true)
        coronavirusMap.addAnnotation(annotation)
        coronavirusMap.selectAnnotation(annotation, animated: true)
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CoronavirusStatisticDetailControllerViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return provinceData!.0.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "provinceCell") as? CoronavirusStatisticDetailCell
        cell?.backgroundColor = UIColor.black
        if provinceData!.0[indexPath.row]!.province == "" {
            cell?.provinceName.text = provinceData!.0[indexPath.row]?.country
        } else {
            cell?.provinceName.text = provinceData!.0[indexPath.row]!.province
        }
        cell?.infected.text = "\(provinceData!.0[indexPath.row]!.latest)"
        cell?.died.text =  "\(provinceData!.1[indexPath.row]!.latest)"
        cell?.recovered.text =  "\(provinceData!.2[indexPath.row]!.latest)"
        return cell!
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let locations = provinceData?.0[indexPath.row]
        showLocation(place: locations)
    }
}

extension CoronavirusStatisticDetailControllerViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var coronavirusAnnotationView = coronavirusMap.dequeueReusableAnnotationView(withIdentifier: "coronavirusAnnotation")
        coronavirusAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "coronavirusAnnotation")
        coronavirusAnnotationView?.canShowCallout = true
        if annotation === coronavirusMap.userLocation {
            coronavirusAnnotationView?.annotation = annotation
            return coronavirusAnnotationView
        } else if annotation !== coronavirusMap.userLocation {
            coronavirusAnnotationView?.image = UIImage(named: "PinClipart.com_video-editing-clip-art_2180392 — копия")
             return coronavirusAnnotationView
        }
        return coronavirusAnnotationView
    }
}

class CoronavirusStatisticDetailCell: UITableViewCell {
    @IBOutlet weak var provinceName: UILabel!
    @IBOutlet weak var infected: UILabel!
    @IBOutlet weak var died: UILabel!
    @IBOutlet weak var recovered: UILabel!
}
