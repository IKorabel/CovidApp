//
//  BasicTypeArrayExtension.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 02.02.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation

public extension Array where Element: Hashable {
    func uniqued() -> [Element] {
        var seen = Set<Element>()
        return filter{ seen.insert($0).inserted }
    }
}
