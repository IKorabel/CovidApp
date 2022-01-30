//
//  СoronaInfoViewController.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 25.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

var tabBarResult = 0
var informationNumber = 0

class CovidGuideViewController: UIViewController {
    @IBOutlet weak var coronaInfoTableView: UITableView!
    var coronavirusInfomation = CoronavirusInfomation()
    var tabBar = TabBarController()
    
    var informationTheme: CovidInformationTheme {
        switch tabBarResult {
        case 1: return .symptoms
        case 2: return .spreadpaths
        case 3: return .precautions
        default: return .precautions
      }
   }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIElements()
        // Do any additional setup after loading the view.
    }
    
    func configureUIElements() {
        configureNavigationBar()
        implementTableView()
        viewsSettings()
    }
    
    func viewsSettings() {
        coronaInfoTableView.backgroundColor = .clear
        view.backgroundColor = .secondarySystemBackground
    }
    
    func configureNavigationBar() {
        navigationController?.navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor : informationTheme.tintColor]
        title = informationTheme.title
    }
    
    func implementTableView() {
        coronaInfoTableView.tableFooterView = UIView()
        coronaInfoTableView.layer.cornerRadius = 20
    }
}

extension CovidGuideViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationTheme.advices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "coronavirusInfoCell") as? CoronavirusInfomationCell else { return UITableViewCell() }
        cell.setInformation(information: informationTheme.advices[indexPath.row], tintColor: informationTheme.tintColor)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
         label.textColor = .systemGray
         label.font = label.font.withSize(8)
         label.numberOfLines = 0
         label.text = "         \(NSLocalizedString("WHO", comment: ""))"
         label.textAlignment = .left
         return label
    }
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
        coronaInfoTableView.tableFooterView?.isHidden = true
    }
    
}
