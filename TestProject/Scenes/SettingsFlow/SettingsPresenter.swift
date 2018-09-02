//
//  SettingsPresenter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 25.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

enum SettingsSceneState {
    case initial
    case isLogouting
    case logouted
}

protocol SettingsPresenterOutput: class {
    func stateDidChange(_ state: SettingsSceneState)
}

final class SettingsPresenter {
    
    // MARK: - Vars
    
    private var state: SettingsSceneState = .initial {
        didSet {
            output?.stateDidChange(state)
        }
    }
    
    weak var output: SettingsPresenterOutput?
    
    // MARK: - Public
    
    func handleLogoutTap() {
        state = .isLogouting
//        UserSessionService.shared.closeUserSessionWithCopletion {
//            self.state = .logouted
//        }
    }
}
