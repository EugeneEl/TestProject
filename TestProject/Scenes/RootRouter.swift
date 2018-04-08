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
    }
    
    // MARK: - Public
    
    /// Build navigaion flow.
    func buildNavigationFlow() {
        let initialViewController = createInitialViewController()
        
        window?.rootViewController = initialViewController
        window?.makeKeyAndVisible()
    }
    
    /// Create initial `UIViewController` depending on user flow.
    ///
    /// - Returns: An instance of `UIViewController` which will be set as a root.
    func createInitialViewController() -> UIViewController {
        return LoginVC.instantiateFromStoryboardId(.login)
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
}
