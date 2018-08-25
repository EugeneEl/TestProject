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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //configureNavigationBarUI()
    }
    
    // MARK: - Public
    
    func setupNavigationWithLaunchOptions(_ options: [UIApplicationLaunchOptionsKey: Any]?) {
        viewControllers = [ListVC.instantiateFromStoryboardId(.main), SettingsVC.instantiateFromStoryboardId(.settings)]
    }
}

// MARK: - ViewControllerUIConfigurating

extension MenuTabBarVC: ViewControllerUIConfigurating {
    var navigationBarAppearance: NavigationBarAppearance? {
        return nil
    }
    
    var isNavigationBarHidden: Bool {
        return true
    }
    
    var isBackButtonVisible: Bool {
        return false
    }
}
