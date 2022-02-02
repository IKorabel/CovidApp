//
//  CLLocationExtension.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 04.04.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import Foundation
import MapKit

extension CLLocation {
func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
    CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}

extension MKAnnotationView {
    
    func setSystemImage(systemImageName: String, imageTintColor: UIColor) {
        guard let systemImage = UIImage(systemName: systemImageName) else { return }
        let coloredSystemImage = systemImage.withTintColor(imageTintColor)
        let size = CGSize(width: 30, height: 30)
        self.image = UIGraphicsImageRenderer(size:size).image { _ in coloredSystemImage.draw(in:CGRect(origin:.zero, size:size)) }
    }
}

