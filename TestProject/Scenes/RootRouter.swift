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
    //let appCoordinator: ApplicationCoordinator = ApplicationCoordinator()
    
    // MARK: - Initialization
    
    init(_ window: UIWindow?) {
        self.window = window
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
        
        return [loginVC]
        
//        if UserSessionService.shared.canRestoreUsesSession() {
//            let menuTabBarVC = MenuTabBarVC.instantiateFromStoryboardId(.main)
//            menuTabBarVC.configureWithLaunchOptions(options)
//            return [loginVC, MenuTabBarVC.instantiateFromStoryboardId(.main)]
//        } else {
//            return [loginVC]
//        }
    }

    // MARK: - Private
    
    @objc private func handleLogout() {
        if let navigationController = window?.rootViewController as? UINavigationController {
            navigationController.popViewController(animated: true)
        }
    }
    
    @objc private func handleLogin() {
        if let navigationController = window?.rootViewController as? UINavigationController {
            let menuTabBarVC = MenuTabBarVC.instantiateFromStoryboardId(.main)
            menuTabBarVC.configureWithLaunchOptions(nil)
            navigationController.pushViewController(menuTabBarVC, animated: true)
        }
    }
}

// MARK: - LoginRouterDelegate

extension RootRouter: LoginRouterDelegate {
    func userDidLoginWithSession(_ session: UserSessionService) {
        if let nc = window?.rootViewController as? UINavigationController {
            let menuTabBarVC = MenuTabBarVC.instantiateFromStoryboardId(.main)
            nc.pushViewController(menuTabBarVC, animated: true)
        }
    }
}
