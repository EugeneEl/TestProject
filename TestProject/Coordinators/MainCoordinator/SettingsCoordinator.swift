//
//  SettingsCoordinator.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

class SettingsCoordinator: Coordinator {
    
    // MARK: - Vars
    
    private let settingsBuilder: SettingsSceneBuilder
    
    // MARK: - Initialization
    
    init(userSessionService: UserSessionService) {
        self.settingsBuilder = SettingsSceneBuilder(userSessionService: userSessionService)
        super.init(flow: .list)
    }
    
    // MARK: - Public
    
    func provideSettingsScene() -> UIViewController {
        let navigationController = BaseNavigationController(rootViewController: settingsBuilder.buildSettingsScene())
        return navigationController
    }
}
