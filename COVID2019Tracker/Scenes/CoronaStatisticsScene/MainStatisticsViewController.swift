//
//  ViewController.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 01.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

class MainStatisticsViewController: UIViewController {
    @IBOutlet weak var covidTableView: UITableView!
    @IBOutlet weak var mainStatisticsCollectionView: UICollectionView!
    
    var coronavirusStatistic: CovidStatistics?

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        implementTableView()
        implementCollectionView()
        requestCovidData()
    }
    
    func requestCovidData() {
        APIService.shared.requestCovidData { [self] loadedCovidStatistics in
            guard let covidStatistics = loadedCovidStatistics else { return }
            coronavirusStatistic = covidStatistics
            DispatchQueue.main.async { covidTableView.reloadData() }
            DispatchQueue.main.async { mainStatisticsCollectionView.reloadData() }
        }
    }
    
    func implementTableView() {
        covidTableView.delegate = self
        covidTableView.dataSource = self
        covidTableView.separatorStyle = .singleLine
    }
    
    func implementCollectionView() {
        mainStatisticsCollectionView.delegate = self
        mainStatisticsCollectionView.dataSource = self
        mainStatisticsCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in
            switch sectionNumber {
            case 0:
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                                        heightDimension: .fractionalHeight(0.33))
                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(300))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 3)
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                return section
            case 1:
                let layoutSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                                        heightDimension: .absolute(150))
                let item = NSCollectionLayoutItem(layoutSize: layoutSize)
                item.contentInsets.top = 10
                let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .absolute(600))
                let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.leading = 5
                section.contentInsets.trailing = 5
                section.contentInsets.top = 5
                return section
            default:
                return nil
            }
        }
    }
}


 

//MARK: TableView
extension MainStatisticsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let covidStatistics = coronavirusStatistic else { return 0 }
        return covidStatistics.countries.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            guard let worldStatisticsCell = tableView.dequeueReusableCell(withIdentifier: "mainInfoCell") as? CovidMainInfoTableViewCell else { return UITableViewCell() }
            guard let globalStatistics = coronavirusStatistic?.global else { return worldStatisticsCell }
           worldStatisticsCell.setMainInformation(globalStatistics: globalStatistics)
          return worldStatisticsCell
        } else {
         guard let countryStatisticsCell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CovidTableViewCell else {
                return UITableViewCell()
         }
        guard let countries = coronavirusStatistic?.countries else { return countryStatisticsCell }
        countryStatisticsCell.setInformation(country: countries[indexPath.row])
         return countryStatisticsCell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = covidTableView.indexPathForSelectedRow else { return }
        guard segue.identifier == "showDetail" else { return }
        guard let detailVC = segue.destination as? RegionalAdditionalStatisticsViewController else { return }
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
        case 0:
            return 3
        case 1:
            guard let countries = coronavirusStatistic?.countries else { return 1 }
            return countries.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
        let cellIdentifier = MainStatisticsVCConstants.worldwideStatisticsCellIdenntifier.rawValue
       guard let worldwideStatisticsCell = collectionView.dequeueReusableCell (withReuseIdentifier: cellIdentifier, for: indexPath) as? WorldwideStatisticsCollectionViewCell
            else { return UICollectionViewCell() }
        guard let statistics = coronavirusStatistic?.global else { return worldwideStatisticsCell }
        worldwideStatisticsCell.setCategoryInformation(information: statistics, indexPath: indexPath)
        return worldwideStatisticsCell
        case 1:
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
    
    
}
