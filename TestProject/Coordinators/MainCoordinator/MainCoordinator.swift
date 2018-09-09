//
//  MainCoordinator.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    // MARK: - Vars
    
    let menuTabBarVC = MenuTabBarVC.instantiateFromStoryboardId(.main)
    let listCoordinator: ListCoordinator = ListCoordinator()
    let settingsCoordinator: SettingsCoordinator
    
    // MARK: - Initialization
    
    init(userSessionService: UserSessionService) {
        self.settingsCoordinator = SettingsCoordinator(userSessionService: userSessionService)
        super.init(flow: .tabBar)
    }
    
    // MARK: - Public
    
    func buildMainMenuWithLaunchOptions(_ options: [UIApplicationLaunchOptionsKey: Any]?) -> UIViewController {
        let mainNavigationVC = listCoordinator.provideListScene()
        let settingsNavigationVC = settingsCoordinator.provideSettingsScene()

        menuTabBarVC.viewControllers = [mainNavigationVC, settingsNavigationVC]
        
        return menuTabBarVC
    }
}


