//
//  WorldwideStatisticsCollectionViewCell.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 30.01.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import UIKit

class WorldwideStatisticsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryAmountLael: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setShape()
    }
    
    private func setShape() {
        layer.cornerRadius = 20
        backgroundColor = .white
    }
    
    func setCategoryInformation(information: Global, indexPath: IndexPath) {
        guard let rawValue = Int("\(indexPath.section)\(indexPath.row)") else {
        print("Не удалось преобразовать")
        return
        }
        guard let statisticsCategory = StatisticsCategory(rawValue: rawValue) else { return }
        let amount = "\(statisticsCategory.defineKindOfIndormationDependsOnIndex(information: information))"
        let categoryColor = statisticsCategory.categoryColor
        categoryAmountLael.textColor = statisticsCategory.amountLabelTextColor
        categoryImage.tintColor = categoryColor
        categoryNameLabel.textColor = categoryColor
        categoryAmountLael.text = "\(amount)\n \(NSLocalizedString("People", comment: "amountOfPeople"))"
        categoryImage.image = statisticsCategory.iconForCategoryImage
        categoryNameLabel.text = statisticsCategory.categoryTitle
    }
    
    
}

extension WorldwideStatisticsCollectionViewCell {
    
    enum StatisticsCategory: Int {
        case deaths = 10
        case confirmed = 11
        case recovered = 12
        case newDeaths = 00
        case newConfirmed = 01
        case newRecovered = 02
        
        var categoryColor: UIColor {
            switch self {
            case .confirmed, .newConfirmed:
                return .systemOrange
            case .deaths, .newDeaths:
                return .systemPink
            case .recovered, .newRecovered:
                return .systemBlue
            }
        }
        
        var amountLabelTextColor: UIColor {
            switch self {
            case .deaths,.confirmed,.recovered: return .label
            case .newDeaths,.newConfirmed,.newRecovered: return .systemBlue
            }
        }
                
        var categoryTitle: String {
            switch self {
            case .deaths, .newDeaths:
                return NSLocalizedString("Dead", comment: "")
            case .confirmed, .newConfirmed:
                return NSLocalizedString("Confirmed", comment: "")
            case .recovered, .newRecovered:
                return NSLocalizedString("Recovered", comment: "")
            }
        }
        
        var iconForCategoryImage: UIImage {
            switch self {
            case .confirmed, .newConfirmed:
                return UIImage(systemName: "facemask.fill")!
            case .deaths, .newDeaths:
                return UIImage(systemName: "heart.slash")!
            case .recovered, .newRecovered:
                return UIImage(systemName: "heart.text.square.fill")!
            }
        }
        
        var categoryImage: UIImageView {
            let imageView = UIImageView(image: iconForCategoryImage)
            imageView.tintColor = categoryColor
            return imageView
        }
        
        func defineKindOfIndormationDependsOnIndex(information: Global) -> String {
            switch self {
            case .deaths:
                return "\(information.totalDeaths)"
            case .confirmed:
                return "\(information.totalConfirmed)"
            case .recovered:
                return "\(information.totalRecovered)"
            case .newDeaths:
                return "+\(information.newDeaths)"
            case .newConfirmed:
                return "+\(information.newConfirmed)"
            case .newRecovered:
                return "+\(information.newRecovered)"
            }
        }
    }
}
