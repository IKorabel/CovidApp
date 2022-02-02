//
//  AppTabBarController.swift
//  COVID2019Tracker
//
//  Created by Игорь Корабельников on 02.02.2022.
//  Copyright © 2022 Игорь Корабельников. All rights reserved.
//

import Foundation
import UIKit

class AppTabBarController: UITabBarController, UITabBarControllerDelegate {
    var result = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        let tabBarIndex = tabBarController.selectedIndex
        result = tabBarIndex
        tabBarResult = tabBarIndex
    }
}
