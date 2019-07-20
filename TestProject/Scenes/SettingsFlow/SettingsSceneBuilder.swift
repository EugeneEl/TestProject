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
        let presenter = SettingsPresenter(userSessionService: userSessionService)
        let vc = SettingsVC(presenter: presenter)
        presenter.view = vc

        return vc
    }
}
