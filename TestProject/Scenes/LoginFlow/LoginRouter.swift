//
//  LoginRouter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 08.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

/// LoginRouter encapsulates logic for navigation on login scene.
final class LoginRouter {
    
    // MARK: - Vars
    
    private weak var viewController: LoginVC?
    
    // MARK: - Initialization
    
    init(viewController: LoginVC) {
        self.viewController = viewController
    }
    
    // MARK: - Public
    
    func navigateToMainScene() {
        let listVC = ListVC.instantiateFromStoryboardId(.main)
        viewController?.navigationController?.pushViewController(listVC, animated: true)
    }
}
