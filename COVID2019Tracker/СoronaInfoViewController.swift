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

class CoronaInfoVC: UIViewController {
    @IBOutlet weak var coronaInfoTableView: UITableView!
    
    var coronaInfoTableViewData: [CoronavirusInformation] {
        switch tabBarResult {
        case 1:
            return [CoronavirusInformation(informationText: NSLocalizedString("laboredBreathing", comment: ""),         informationImage: #imageLiteral(resourceName: "lung 1"))
                   ,CoronavirusInformation(informationText: NSLocalizedString("Fever", comment: ""), informationImage: #imageLiteral(resourceName: "heat 1")),
                    CoronavirusInformation(informationText: NSLocalizedString("Dry cough", comment: ""), informationImage: #imageLiteral(resourceName: "cough 1"))]
        case 2:
            return [CoronavirusInformation(informationText: NSLocalizedString("Sneezing", comment: ""), informationImage: #imageLiteral(resourceName: "cough-3 1")),
                    CoronavirusInformation(informationText: NSLocalizedString("Cough", comment: ""), informationImage: #imageLiteral(resourceName: "cough 1")),
                    CoronavirusInformation(informationText: NSLocalizedString("DirtyHands", comment: ""), informationImage: #imageLiteral(resourceName: "Group-1")),
                    CoronavirusInformation(informationText: NSLocalizedString("Kisses", comment: ""), informationImage: #imageLiteral(resourceName: "kiss 1")),
                    CoronavirusInformation(informationText: NSLocalizedString("Snot", comment: ""), informationImage: #imageLiteral(resourceName: "cough-2 1"))]
        case 3:
            return [CoronavirusInformation(informationText: NSLocalizedString("stayHome", comment: ""), informationImage: #imageLiteral(resourceName: "living 1")),
                    CoronavirusInformation(informationText: NSLocalizedString("WearFFP3", comment: ""), informationImage: #imageLiteral(resourceName: "medical-mask 1")),
                    CoronavirusInformation(informationText: NSLocalizedString("WashHands", comment: ""), informationImage: #imageLiteral(resourceName: "hand-wash 1")),
                    CoronavirusInformation(informationText: NSLocalizedString("DoNotTouchTheFace", comment: ""), informationImage: #imageLiteral(resourceName: "Group 6")),
                    CoronavirusInformation(informationText: NSLocalizedString("WipeSmartphone", comment: ""), informationImage: UIImage(named: "Group 7")!)]
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
    var tabBar = TabBarController()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        print(tabBarResult)
    }
}

extension CoronaInfoVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coronaInfoTableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.backgroundColor = UIColor.black
        tableView.tableFooterView = UIView()
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

class CoronavirusInfomationCell: UITableViewCell {
    @IBOutlet weak var coronavirusInfoLabel: UILabel!
    @IBOutlet weak var coronavirusInfoImage: UIImageView!
}
