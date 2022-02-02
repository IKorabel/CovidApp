//
//  ViewController.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 01.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

class GlobalStatisticsViewController: UIViewController {
    @IBOutlet weak var globalStatisticsCollectionView: UICollectionView!
    
    var globalStatistics: GlobalStatistics?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSettingsToView()
        requestCovidData()
    }
    
    func requestCovidData() {
        APIService.shared.requestCovidData(link: .summaryStatisticsLink) { [self] loadedCovidStatistics in
            guard let covidStatistics = loadedCovidStatistics as? GlobalStatistics else { return }
            globalStatistics = covidStatistics
            globalStatistics?.countries.sort(by: {$0.totalConfirmed > $1.totalConfirmed})
            DispatchQueue.main.async { globalStatisticsCollectionView.reloadData() }
        }
    }
    
    func setSettingsToView() {
        view.backgroundColor = .secondarySystemBackground
        implementCollectionView()
    }
    
    func implementCollectionView() {
        globalStatisticsCollectionView.delegate = self
        globalStatisticsCollectionView.dataSource = self
        globalStatisticsCollectionView.collectionViewLayout = createCompositionalLayout()
        globalStatisticsCollectionView.backgroundColor = .clear
        globalStatisticsCollectionView.register(ASCollectionViewHeader.self,
                                              forSupplementaryViewOfKind: ASCollectionViewHeader.reuseIdentifier,
                                              withReuseIdentifier: ASCollectionViewHeader.reuseIdentifier)
    }
    
    func makeSegueToRegionalVC(countryCodeToPass: String) {
        guard let regionalStatisticsVC = storyboard?.instantiateViewController(withIdentifier: GlobalStatisticsSceneConstants.SegueVCIdentifiers.regionalAdditionalStatisticsVC) as? RegionalAdditionalStatisticsViewController else { return }
        regionalStatisticsVC.countryCode = countryCodeToPass
        navigationController?.pushViewController(regionalStatisticsVC, animated: true)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0...1: return CompositionalLayoutStorage.globalStatisticsCubeCell
            case 2: return CompositionalLayoutStorage.regionCell
            default: return nil
            }
        }
    }
}



//MARK: UICollectionView

extension GlobalStatisticsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0...1: return 2
        case 2:
            guard let countries = globalStatistics?.countries else { return 1 }
            return countries.count
        default: return 0
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let sectionHeaders = ["Today","World", NSLocalizedString("COUNTRIES", comment: "headerMain2Section")]
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: ASCollectionViewHeader.reuseIdentifier, for: indexPath) as? ASCollectionViewHeader else {
        return UICollectionReusableView()
        }
        header.setHeader(title: sectionHeaders[indexPath.section], buttonImage: nil)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0...1:
            let cellIdentifier = GlobalStatisticsSceneConstants.CellIdentifiers.globalStatisticsCell
       guard let worldwideStatisticsCell = collectionView.dequeueReusableCell (withReuseIdentifier: cellIdentifier, for: indexPath) as? GlobalStatisticsCollectionViewCell
            else { return UICollectionViewCell() }
        guard let statistics = globalStatistics?.global else { return worldwideStatisticsCell }
        worldwideStatisticsCell.setCategoryInformation(information: statistics, indexPath: indexPath)
        return worldwideStatisticsCell
        case 2:
            
        let countriesCellId = GlobalStatisticsSceneConstants.CellIdentifiers.countriesStatisticsCell
        guard let countriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: countriesCellId, for: indexPath) as? CountriesStatisticsCollectionViewCell else { return UICollectionViewCell() }
        countriesCell.setCountry(country: globalStatistics?.countries[indexPath.row])
        return countriesCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let countries = globalStatistics?.countries else { return }
        guard indexPath.section == 2 else { return }
        let countryCode = countries[indexPath.row].countryCode
        makeSegueToRegionalVC(countryCodeToPass: countryCode)
    }
    
    
}
