//
//  ViewController.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 01.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit
import Alamofire
import MapKit

class CoronaStatisticVC: UIViewController {
    @IBOutlet weak var covidTableView: UITableView!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    var coronavirusStatistic: CovidStatistics?
    var userCountryName = String()
    var countryFromArray = String()
    var casesInfo = ([LocationData](),[LocationData](),[LocationData]())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        implementTableView()
        requestCovidData()
    }
    
    func requestCovidData() {
        APIService.shared.requestCovidData { [self] loadedCovidStatistics in
            guard let covidStatistics = loadedCovidStatistics else { return }
            coronavirusStatistic = covidStatistics
            DispatchQueue.main.async { covidTableView.reloadData() }
        }
    }
    
    func implementTableView() {
        covidTableView.delegate = self
        covidTableView.dataSource = self
        covidTableView.separatorStyle = .singleLine
    }
    
    func convertToComfortableArray(obj: [LocationData]) -> [LocationData] {
        let confirmedMerged = obj
        let new = confirmedMerged.reduce([LocationData]()) { result, location in
         var temp = result
         guard let index = result.firstIndex(where: { $0.country == location.country }) else {
             temp.append(location)
             return temp }
         temp[index].latest = result[index].latest + location.latest
         return temp
        }
        return new.sorted { ($0.latest > $1.latest)}
    }
    
    func findProvinceStatistic(countryName: String,array: [LocationData]) -> [LocationData] {
        var provinceStatisticArray = [LocationData]()
        for elem in array { if elem.country == countryName { provinceStatisticArray.append(elem) } }
        return provinceStatisticArray.sorted { ($0.latest > $1.latest)}
    }
}


 

//MARK: TableView
extension CoronaStatisticVC: UITableViewDelegate, UITableViewDataSource {
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
        guard let detailVC = segue.destination as? CoronavirusProvinceMapStatisticsVC else { return }
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



