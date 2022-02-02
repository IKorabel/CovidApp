//
//  CompositionalLayoutStorage.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 02.02.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation
import UIKit

struct CompositionalLayoutStorage {
    
    static var regionCell: NSCollectionLayoutSection {
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
    }
    
    static var globalStatisticsCubeCell: NSCollectionLayoutSection {
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
    }
    
}
