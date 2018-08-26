//
//  MenuTabBarVC.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 25.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

class MenuTabBarVC: UITabBarController {
    
    // MARK: - Lifecycle
    
    // MARK: - Public
    
    func setupNavigationWithLaunchOptions(_ options: [UIApplicationLaunchOptionsKey: Any]?) {
        
        let mainNavigationVC = BaseNavigationController(rootViewController: ListVC.instantiateFromStoryboardId(.main))
        let settingsNavigationVC = BaseNavigationController(rootViewController: SettingsVC.instantiateFromStoryboardId(.settings))
        viewControllers = [mainNavigationVC, settingsNavigationVC]
    }
}
