//
//  Helpers.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 09.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

class Helpers {
    static func customNavigationBar() {
       let navigationBar = UINavigationBar.appearance()
       navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       navigationBar.barTintColor = UIColor.blue
       navigationBar.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
       navigationBar.shadowImage = UIImage()
    }
}
