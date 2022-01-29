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

class CoronavirusInfomationVC: UIViewController {
    @IBOutlet weak var coronaInfoTableView: UITableView!
    var coronavirusInfomation = CoronavirusInfomation()
    var tabBar = TabBarController()
    
    var coronaInfoTableViewData: [CoronavirusInformationCellData] {
        switch tabBarResult {
        case 1:
            return coronavirusInfomation.symptoms
        case 2:
            return coronavirusInfomation.spreadPaths
        case 3:
            return coronavirusInfomation.precautions
        default:
            return []
        }
    }

    
    var typeOfInfo: String {
        switch tabBarResult {
           case 1:
           return NSLocalizedString("SYMPTOMS", comment: "")
           case 2:
           return NSLocalizedString("TRANSFER", comment: "")
           case 3:
           return NSLocalizedString("DEFENCE", comment: "")
           default:
           return ""
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        implementTableView()
        // Do any additional setup after loading the view.
    }
    
    func implementTableView() {
        coronaInfoTableView.backgroundColor = UIColor.black
        coronaInfoTableView.tableFooterView = UIView()
    }
}

extension CoronavirusInfomationVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coronaInfoTableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "coronavirusInfoCell") as! CoronavirusInfomationCell
        cell.coronavirusInfoImage.image = coronaInfoTableViewData[indexPath.row].informationImage
        cell.coronavirusInfoLabel.text = coronaInfoTableViewData[indexPath.row].informationText
        return cell
    }
    

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.textColor = #colorLiteral(red: 0.3902949691, green: 0.4379927218, blue: 0.5106592774, alpha: 1)
        label.text = "    \(typeOfInfo)"
        label.textAlignment = .left
        return label
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
         label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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

