//
//  ViewController.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 01.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

class MainStatisticsViewController: UIViewController {
    @IBOutlet weak var mainStatisticsCollectionView: UICollectionView!
    
    var coronavirusStatistic: CovidStatistics?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSettingsToView()
        requestCovidData()
    }
    
    func requestCovidData() {
        APIService.shared.requestCovidData(link: .summaryStatisticsLink) { [self] loadedCovidStatistics in
            guard let covidStatistics = loadedCovidStatistics as? CovidStatistics else { return }
            coronavirusStatistic = covidStatistics
            DispatchQueue.main.async { mainStatisticsCollectionView.reloadData() }
        }
    }
    
    func setSettingsToView() {
        view.backgroundColor = .secondarySystemBackground
        implementCollectionView()
    }
    
    func implementCollectionView() {
        mainStatisticsCollectionView.delegate = self
        mainStatisticsCollectionView.dataSource = self
        mainStatisticsCollectionView.collectionViewLayout = createCompositionalLayout()
        mainStatisticsCollectionView.backgroundColor = .clear
        mainStatisticsCollectionView.register(ASCollectionViewHeader.self,
                                              forSupplementaryViewOfKind: ASCollectionViewHeader.reuseIdentifier,
                                              withReuseIdentifier: ASCollectionViewHeader.reuseIdentifier)
    }
    
    func makeSegueToRegionalVC(countryCodeToPass: String) {
        guard let regionalStatisticsVC = storyboard?.instantiateViewController(withIdentifier: "RegionalAdditionalStatisticsViewController") as? RegionalAdditionalStatisticsViewController else { return }
        regionalStatisticsVC.countryCode = countryCodeToPass
        navigationController?.pushViewController(regionalStatisticsVC, animated: true)
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0...1:
                let layoutSize = NSCollectionLayoutSize(widthDimension: .absolute(80),
                                                        heightDimension: .absolute(150))
                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                item.contentInsets.trailing = 10
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(180))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 10
                section.contentInsets.top = 10
                section.boundarySupplementaryItems = [
                    .init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: ASCollectionViewHeader.reuseIdentifier, alignment: .topLeading)
                ]
                return section
            case 2:
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
                return section
            default:
                return nil
            }
        }
    }
}

//MARK: TabBar
class TabBarController: UITabBarController, UITabBarControllerDelegate {
    var result = Int()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        result = tabBarIndex
        tabBarResult = tabBarIndex
    }
}



//MARK: UICollectionView

extension MainStatisticsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0...1:
            return 2
        case 2:
            guard let countries = coronavirusStatistic?.countries else { return 1 }
            return countries.count
        default:
            return 0
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
        print("header")
        header.setHeader(title: sectionHeaders[indexPath.section], buttonImage: nil)
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0...1:
        let cellIdentifier = MainStatisticsVCConstants.worldwideStatisticsCellIdenntifier.rawValue
       guard let worldwideStatisticsCell = collectionView.dequeueReusableCell (withReuseIdentifier: cellIdentifier, for: indexPath) as? WorldwideStatisticsCollectionViewCell
            else { return UICollectionViewCell() }
        guard let statistics = coronavirusStatistic?.global else { return worldwideStatisticsCell }
        worldwideStatisticsCell.setCategoryInformation(information: statistics, indexPath: indexPath)
        return worldwideStatisticsCell
        case 2:
        let countriesCellId = MainStatisticsVCConstants.countriesStatisticsCell.rawValue
        guard let countriesCell = collectionView.dequeueReusableCell(withReuseIdentifier: countriesCellId, for: indexPath) as? CountriesStatisticsCollectionViewCell else {
            print("incorrect id")
            return UICollectionViewCell()
        }
            countriesCell.setCountry(country: coronavirusStatistic?.countries[indexPath.row])
        return countriesCell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let countries = coronavirusStatistic?.countries else { return }
        guard indexPath.section == 2 else { return }
        let countryCode = countries[indexPath.row].countryCode
        makeSegueToRegionalVC(countryCodeToPass: countryCode)
        print(countryCode)
    }
    
    
}
