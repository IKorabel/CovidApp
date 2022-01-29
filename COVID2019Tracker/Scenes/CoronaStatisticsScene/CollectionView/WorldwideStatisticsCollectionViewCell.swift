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
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray.cgColor
    }
    
    func setCategoryInformation(information: Global, indexPath: IndexPath) {
        guard let statisticsCategory = StatisticsCategory(rawValue: indexPath.row) else { return }
        let amount = "\(statisticsCategory.defineKindOfIndormationDependsOnIndex(information: information))"
        let categoryColor = statisticsCategory.categoryColor
        categoryImage.tintColor = categoryColor
        categoryNameLabel.textColor = categoryColor
        categoryAmountLael.text = amount
        categoryImage.image = statisticsCategory.iconForCategoryImage
        categoryNameLabel.text = statisticsCategory.categoryTitle
    }
    
    
}

extension WorldwideStatisticsCollectionViewCell {
    
    enum StatisticsCategory: Int {
        case deaths = 0
        case confirmed = 1
        case recovered = 2
        
        var categoryColor: UIColor {
            switch self {
            case .confirmed:
                return .systemOrange
            case .deaths:
                return .systemPink
            case .recovered:
                return .systemBlue
            }
        }
                
        var categoryTitle: String {
            switch self {
            case .deaths:
                return NSLocalizedString("Dead", comment: "")
            case .confirmed:
                return NSLocalizedString("Confirmed", comment: "")
            case .recovered:
                return NSLocalizedString("Recovered", comment: "")
            }
        }
        
        var iconForCategoryImage: UIImage {
            switch self {
            case .confirmed:
                return UIImage(systemName: "facemask.fill")!
            case .deaths:
                return UIImage(systemName: "heart.slash")!
            case .recovered:
                return UIImage(systemName: "heart.text.square.fill")!
            }
        }
        
        var categoryImage: UIImageView {
            let imageView = UIImageView(image: iconForCategoryImage)
            imageView.tintColor = categoryColor
            return imageView
        }
        
        func defineKindOfIndormationDependsOnIndex(information: Global) -> Int {
            switch self {
            case .deaths:
                return information.totalDeaths
            case .confirmed:
                return information.totalConfirmed
            case .recovered:
                return information.totalRecovered
            }
        }
    }
}
