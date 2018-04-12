//
//  ListRouter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 12.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class ListRouter {
    
    // MARK: - Vars
    
    private weak var viewController: ListVC?
    
    // MARK: - Initialization
    
    init(viewController: ListVC) {
        self.viewController = viewController
    }
    
    // MARK: - Public
    
    func navigateToMainScene() {
        
    }
}
