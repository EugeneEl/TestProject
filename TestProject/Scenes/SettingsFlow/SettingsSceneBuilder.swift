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
    
    func buildSettingsScene() -> SettingsVC {
        let vc = SettingsVC.instantiateFromStoryboardId(.settings)
        let presenter = SettingsPresenter(userSessionService: userSessionService)
        presenter.settingsViewInput = vc
        vc.presenter = presenter

        return vc
    }
}
