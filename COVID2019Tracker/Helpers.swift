//
//  Helpers.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 09.03.2020.
//  Copyright © 2020 Игорь Корабельников. All rights reserved.
//

import UIKit

class Helpers: NSObject {
    
    static func customNavigationBar() {
       let navigationBar = UINavigationBar.appearance()
       navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
       navigationBar.topItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
       navigationBar.barTintColor = UIColor.white
       navigationBar.backgroundColor = UIColor.black
       navigationBar.shadowImage = UIImage()
    }
}
