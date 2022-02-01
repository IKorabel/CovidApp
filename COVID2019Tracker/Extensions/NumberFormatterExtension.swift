//
//  NumberFormatterExtension.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 31.01.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation

extension Formatter {
    static let withSeparator: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.groupingSeparator = " "
        return formatter
    }()
}

extension Numeric {
    var formattedWithSeparator: String { Formatter.withSeparator.string(for: self) ?? "" }
}
