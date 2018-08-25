//
//  AppDelegate.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 28.03.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import UIKit
import IQKeyboardManager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // MARK: - Vars
    
    var window: UIWindow?
    fileprivate (set) internal var router: RootRouter?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        ServiceLocatorConfigurator.setupServices()
        UserSessionService.shared.closeUserSession()
        setupKeyboardManager()
        setupNavigation()

        return true
    }
    
    // MARK: - Private
    
    private func setupKeyboardManager() {
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().isEnabled = true
    }
    
    private func setupNavigation() {
        router = RootRouter(window)
        router?.buildNavigationFlow()
    }
    
    private func setupWindow() {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
    }
}

