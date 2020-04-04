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
