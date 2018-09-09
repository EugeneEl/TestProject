//
//  SettingsSceneBuilder.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

struct SettingsSceneBuilder {
    
    // MARK: - Vars
    
    let userSessionService: UserSessionService
    
    // MARK: - Public
    
    func buildSettingsScene() -> BaseNavigationController {
        let vc = SettingsVC.instantiateFromStoryboardId(.settings)
        let presenter = SettingsPresenter(userSessionService: userSessionService)
        presenter.output = vc
        vc.presenter = presenter
        
        let navigationController = BaseNavigationController(rootViewController: vc)
        
        return navigationController
    }
}
