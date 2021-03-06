//
//  LoginRouter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 08.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

/// LoginRouter encapsulates logic for navigation on login scene.
final class LoginRouter {
    
    // MARK: - Vars
    
    private weak var viewController: UIViewController?
    
    // MARK: - Initialization
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
}
