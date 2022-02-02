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
    @IBOutlet weak var provincesMap: MKMapView!
    @IBOutlet weak var provinceCollectionView: UICollectionView!
    
    let geoServices = GeoServices.shared
    var countryCode: String?
    var provinceStatistics: [ProvinceStatistics]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestRegionalStatistics()
        implementUIElements()
    }
    
    func showOnMap() {
        geoServices.showPlaces(map: provincesMap, provinceData: provinceStatistics)
    }
    
    func implementUIElements() {
        implementCollectionView()
        implementMapView()
    }
    
    func implementCollectionView() {
        provinceCollectionView.delegate = self
        provinceCollectionView.dataSource = self
        provinceCollectionView.collectionViewLayout = createCollectionViewLayout()
        provinceCollectionView.register(ASCollectionViewHeader.self,
                                        forSupplementaryViewOfKind: ASCollectionViewHeader.reuseIdentifier,
                                        withReuseIdentifier: ASCollectionViewHeader.reuseIdentifier)
        provinceCollectionView.backgroundColor = .secondarySystemBackground
    }
    
    func implementMapView() {
        provincesMap.delegate = self
        provincesMap.layer.cornerRadius = 20
    }
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let regionCell = CompositionalLayoutStorage.regionCell
        return UICollectionViewCompositionalLayout(section: regionCell)
    }
    
    func requestRegionalStatistics() {
        guard let countryCode = countryCode else { return }
        APIService.shared.requestCovidData(link: .countryLiveStatisticsLink(countryCode: countryCode)) { [self] loadedData in
            guard let countryStatistics = loadedData as? [ProvinceStatistics] else { return }
            title = getTheCountryName()
            self.provinceStatistics = countryStatistics.splitByRegions()
            showOnMap()
            DispatchQueue.main.async { provinceCollectionView.reloadData() }
        }
    }
    
    func getTheCountryName() -> String {
        guard let countryStatistics = provinceStatistics else { return ""}
        return countryStatistics.first?.country ?? ""
    }

}

//MapViewDelegate
extension RegionalAdditionalStatisticsViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var coronavirusAnnotationView = provincesMap.dequeueReusableAnnotationView(withIdentifier: "provinceAnnotation")
        
        if coronavirusAnnotationView == nil {
            coronavirusAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "provinceAnnotation")
            coronavirusAnnotationView?.canShowCallout = true
            coronavirusAnnotationView?.setSystemImage(systemImageName: "circle.fill", imageTintColor: .systemRed)
        } else {
            coronavirusAnnotationView?.annotation = annotation
        }
        return coronavirusAnnotationView
     }
}


extension RegionalAdditionalStatisticsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return provinceStatistics?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "countriesStatisticsCell", for: indexPath) as? CountriesStatisticsCollectionViewCell else { return UICollectionViewCell() }
        guard let provinceStatistics = provinceStatistics else { return cell }
        cell.setProvince(province: provinceStatistics[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaders = ["Regions"]
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ASCollectionViewHeader.reuseIdentifier, for: indexPath) as? ASCollectionViewHeader else { return UICollectionReusableView() }
        header.setHeader(title: sectionHeaders[indexPath.section], buttonImage: nil)
        return header
    }
    
    
}
