//
//  QuarantineStocksVC.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 23.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

class QuarantineStocksVC: UIViewController {
    @IBOutlet weak var stocksSegmentedControl: UISegmentedControl!
    @IBOutlet weak var stocksTableView: UITableView!
    
    var currentTableViewIndex = 0
    var stocks = [
        [StockInfo(productName: "Молоко", productAmount: 1, productCallories: 3)],
        [StockInfo(productName: "Кефир", productAmount: 1, productCallories: 3)],
        [StockInfo(productName: "Туалетная бумага", productAmount: 1, productCallories: 3)]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func stocksSegmentAction(_ sender: UISegmentedControl) {
        currentTableViewIndex = sender.selectedSegmentIndex
        stocksTableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class StockCell: UITableViewCell {
    @IBOutlet weak var stockName: UILabel!
    @IBOutlet weak var stockAmount: UILabel!
    @IBOutlet weak var stockCallories: UILabel!
}

extension QuarantineStocksVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stocks[currentTableViewIndex].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        tableView.layer.cornerRadius = 10
        tableView.layer.borderColor = #colorLiteral(red: 0, green: 0.7103787065, blue: 0.6109842658, alpha: 1)
        tableView.layer.borderWidth = 0.5
        let stock = stocks[currentTableViewIndex][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "stockCell") as! StockCell
        cell.stockName.text = stock.productName
        cell.stockAmount.text = "\(stock.productAmount)"
        cell.stockCallories.text = "\(stock.productCallories)"
        return cell
    }
}
