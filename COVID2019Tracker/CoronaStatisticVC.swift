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
    var coronavirusStatistic: Coronavirus?
    var userCountryName = String()
    var countryFromArray = String()
    var casesInfo = ([LocationData](),[LocationData](),[LocationData?]())
    @IBOutlet weak var covidTableView: UITableView!
    @IBOutlet weak var confirmedLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    @IBOutlet weak var recoveredLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        covidTableView.delegate = self
        covidTableView.dataSource = self
        requestCovidData()
    }
    
    func requestCovidData() {
        AF.request("https://coronavirus-tracker-api.herokuapp.com/all").responseJSON { (response) in
            guard response.data != nil else { return }
            let decode = try! JSONDecoder().decode(Coronavirus.self, from: response.data!)
            self.coronavirusStatistic = decode
            self.casesInfo = (self.convertToComfortableArray(obj: self.coronavirusStatistic!.confirmed.locations),
                              self.convertToComfortableArray(obj: self.coronavirusStatistic!.deaths.locations),
                              self.convertToComfortableArray(obj: self.coronavirusStatistic!.recovered.locations))
            DispatchQueue.main.async { self.covidTableView.reloadData() }
        }
    }
    
    func convertToComfortableArray(obj: [LocationData]) -> [LocationData] {
        let confirmedMerged = obj
        let new = confirmedMerged.reduce([LocationData]()) { result, location in
         var temp = result
         guard let index = result.firstIndex(where: { $0.country == location.country }) else { temp.append(location); return temp}
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
        guard coronavirusStatistic != nil else { return 0 }
        return convertToComfortableArray(obj: coronavirusStatistic!.confirmed.locations).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
          let worldStatisticsCell = tableView.dequeueReusableCell(withIdentifier: "mainInfoCell") as! CovidMainInfoTableViewCell
          worldStatisticsCell.infected.text = "\(coronavirusStatistic!.confirmed.latest)"
          worldStatisticsCell.died.text = "\(coronavirusStatistic!.deaths.latest)"
          worldStatisticsCell.recovered.text = "\(coronavirusStatistic!.recovered.latest)"
          tableView.separatorStyle = .singleLine
          return worldStatisticsCell
        } else {
         let countryStatisticsCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CovidTableViewCell
         guard coronavirusStatistic != nil else { countryStatisticsCell.textLabel?.text = "Loading.."; return countryStatisticsCell }
         countryStatisticsCell.regionLabel.text = "\(casesInfo.0[indexPath.row].country)"
         countryStatisticsCell.infectedLabel.text = "\(casesInfo.0[indexPath.row].latest)"
         countryStatisticsCell.deadLabel.text = "\(casesInfo.1[indexPath.row].latest)"
         countryStatisticsCell.recoveredLabel.text = "\(casesInfo.2[indexPath.row]!.latest ?? 0)"
         countryStatisticsCell.separatorInset = UIEdgeInsets(top: 0, left: countryStatisticsCell.bounds.size.width, bottom: 0, right: 0)
         return countryStatisticsCell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let index = covidTableView.indexPathForSelectedRow else { return }
        guard segue.identifier == "showDetail" else { return }
        guard let detailVC = segue.destination as? CoronavirusProvinceMapStatisticsVC else { return }
        let countryName = casesInfo.0[index.row].country
        let provinceCoronavirusInfo =
            (findProvinceStatistic(countryName: countryName, array: (coronavirusStatistic?.confirmed.locations)!)
            ,findProvinceStatistic(countryName: countryName, array: (coronavirusStatistic?.deaths.locations)!)
            ,findProvinceStatistic(countryName: countryName, array: (coronavirusStatistic?.recovered.locations)!))
        detailVC.provinceData = provinceCoronavirusInfo
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



