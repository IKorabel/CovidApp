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
    @IBOutlet weak var provinceCollectionView: UICollectionView!
    
    var geoServices = GeoServices.shared
    var countryCode: String?
    var provinceStatistics: [CovidLiveStatistic]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        requestRegionalStatistics()
        implementUIElements()
    }
    
    func showOnMap() {
        geoServices.showPlaces(map: coronavirusMap, provinceData: provinceStatistics)
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
                                        forSupplementaryViewOfKind: ASCollectionViewHeader.reuseIdentifier, withReuseIdentifier: ASCollectionViewHeader.reuseIdentifier)
        provinceCollectionView.backgroundColor = .secondarySystemBackground
    }
    
    func implementMapView() {
        coronavirusMap.delegate = self
        coronavirusMap.layer.cornerRadius = 20
    }
    
    func createCollectionViewLayout() -> UICollectionViewCompositionalLayout {
        let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                heightDimension: .absolute(150))
        let item = NSCollectionLayoutItem(layoutSize: layoutSize)
        item.contentInsets.top = 10
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(600))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 10
        section.contentInsets.trailing = 10
        section.contentInsets.top = 5
        section.boundarySupplementaryItems = [
            .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: ASCollectionViewHeader.reuseIdentifier, alignment: .topLeading)
        ]
        return UICollectionViewCompositionalLayout(section: section)
    }
    
    func requestRegionalStatistics() {
        guard let countryCode = countryCode else { return }
        APIService.shared.requestCovidData(link: .countryLiveStatisticsLink(countryCode: countryCode)) { [self] loadedData in
            guard let countryStatistics = loadedData as? [CovidLiveStatistic] else { return }
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
        var coronavirusAnnotationView = coronavirusMap.dequeueReusableAnnotationView(withIdentifier: "provinceAnnotation")
        if coronavirusAnnotationView == nil {
            coronavirusAnnotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "provinceAnnotation")
            coronavirusAnnotationView?.canShowCallout = true
            let circle = UIImage(systemName:"circle.fill")!.withTintColor(.systemRed)
            let size = CGSize(width: 30, height: 30)
            coronavirusAnnotationView!.image = UIGraphicsImageRenderer(size:size).image {
                _ in circle.draw(in:CGRect(origin:.zero, size:size))
            }
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
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ASCollectionViewHeader.reuseIdentifier, for: indexPath) as? ASCollectionViewHeader else {
        return UICollectionReusableView()
        }
        print("header")
        header.setHeader(title: sectionHeaders[indexPath.section], buttonImage: nil)
        return header
    }
    
    
}
