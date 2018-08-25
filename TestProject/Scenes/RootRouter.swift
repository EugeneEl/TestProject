//
//  RootRouter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 28.03.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

/// `RootRouter` class encapsulates logic for creating and changing default navigation structure.
final class RootRouter {
    
    // MARK: - Vars
    
    let window: UIWindow?
    
    // MARK: - Initialization
    
    init(_ window: UIWindow?) {
        self.window = window
        self.addListeners()
    }
    
    // MARK: - Public
    
    /// Build navigaion flow.
    func buildNavigationFlow(_ options: [UIApplicationLaunchOptionsKey: Any]?) {
        let initialViewControllers = createInitialViewControllersWithOptions(options)
        
        let rootNavigationController = BaseNavigationController()
        rootNavigationController.viewControllers = initialViewControllers
        
        window?.rootViewController = rootNavigationController
        window?.makeKeyAndVisible()
    }
    
    /// Create initial `UIViewController` depending on user flow.
    ///
    /// - Returns: An array of `UIViewController` which will be set as for navigation.
    func createInitialViewControllersWithOptions(_ options: [UIApplicationLaunchOptionsKey: Any]?) -> [UIViewController] {
        let loginVC = NewLoginVC.instantiateFromStoryboardId(.login)
        loginVC.enforceLoadView()
        
        if UserSessionService.shared.canRestoreUsesSession() {
            let menuTabBarVC = MenuTabBarVC.instantiateFromStoryboardId(.main)
            menuTabBarVC.setupNavigationWithLaunchOptions(options)
            return [loginVC, MenuTabBarVC.instantiateFromStoryboardId(.main)]
        } else {
            return [loginVC]
        }
    }
    
    /// Replace rootViewController with the new one. Used to change navigation "on the fly".
    ///
    /// - Parameter newViewController: An instance of `UIViewController` to be set as a new root.
    func changeRootViewControllerWithoutAnimation(_ newViewController: UIViewController) {
        if (window?.rootViewController == nil) {
            window?.rootViewController = newViewController
            return
        }
        window?.rootViewController = newViewController
    }
    
    // MARK: - Private
    
    private func addListeners() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(handleLogout), name: UserSessionServiceNotification.logout, object: nil)
        notificationCenter.addObserver(self, selector: #selector(handleLogin), name: UserSessionServiceNotification.login, object: nil)
    }
    
    @objc private func handleLogout() {
        if let navigationController = window?.rootViewController as? UINavigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    @objc private func handleLogin() {
        if let navigationController = window?.rootViewController as? UINavigationController {
            let menuTabBarVC = MenuTabBarVC.instantiateFromStoryboardId(.main)
            menuTabBarVC.setupNavigationWithLaunchOptions(nil)
            navigationController.pushViewController(menuTabBarVC, animated: true)
        }
    }
}
