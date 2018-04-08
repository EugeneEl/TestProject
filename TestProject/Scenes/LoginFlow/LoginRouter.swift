//
//  LoginRouter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 08.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class LoginRouter {
    
    // MARK: - Vars
    
    private weak var viewController: LoginVC?
    
    // MARK: - Initialization
    
    init(viewController: LoginVC) {
        self.viewController = viewController
    }
    
    // MARK: - Public
}
