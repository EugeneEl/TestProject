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
    fileprivate (set) internal var applicationCoordinator: ApplicationCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        setupWindow()
        ServiceLocatorConfigurator.setupServices()
        setupKeyboardManager()
        
        applicationCoordinator = ApplicationCoordinator(window: window!, userSessionStorage: UserSessionStorage())
        applicationCoordinator?.startWithLaunchOptions(launchOptions)

        return true
    }
    
    // MARK: - Private
    
    private func setupKeyboardManager() {
        IQKeyboardManager.shared().isEnableAutoToolbar = true
        IQKeyboardManager.shared().isEnabled = true
    }
    
    private func setupWindow() {
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
    }
}

