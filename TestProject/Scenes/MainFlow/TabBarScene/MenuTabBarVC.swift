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
    
    // MARK: - Vars
    
    private var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBarUI()
    }
    
    // MARK: - Public
    
    func configureWithLaunchOptions(_ options: [UIApplication.LaunchOptionsKey: Any]?) {
        launchOptions = options
    }
    
    // MARK: - Private
    
    private func setupTabBarUI() {
        tabBar.tintColor = .white
        tabBar.barTintColor = Constants.Colors.background
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

