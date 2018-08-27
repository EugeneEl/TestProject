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
    
    private var launchOptions: [UIApplicationLaunchOptionsKey: Any]?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabBarUI()
        setupNavigationWithLaunchOptions(launchOptions)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBarUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(viewControllers)
    }
    
    // MARK: - Public
    
    func configureWithLaunchOptions(_ options: [UIApplicationLaunchOptionsKey: Any]?) {
        launchOptions = options
    }
    
    // MARK: - Private
    
    private func setupTabBarUI() {
        tabBar.tintColor = .white
        tabBar.barTintColor = Constants.Colors.background
    }
    
    private func setupNavigationWithLaunchOptions(_ options: [UIApplicationLaunchOptionsKey: Any]?) {
        let mainVC = ListVC.instantiateFromStoryboardId(.main)
        let mainNavigationVC = BaseNavigationController(rootViewController: mainVC)
        mainNavigationVC.enforceLoadView()
        let settingsNavigationVC = BaseNavigationController(rootViewController: SettingsVC.instantiateFromStoryboardId(.settings))
        viewControllers = [mainNavigationVC, settingsNavigationVC]
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

