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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Public
    
    func setupNavigationWithLaunchOptions(_ options: [UIApplicationLaunchOptionsKey: Any]?) {
        viewControllers = [ListVC.instantiateFromStoryboardId(.main), ListVC.instantiateFromStoryboardId(.main)]
    }
}
