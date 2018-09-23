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

protocol SettingsViewInput: class {
    func stateDidChange(_ state: SettingsSceneState)
}

final class SettingsPresenter: SettingsViewOutput {
    
    // MARK: - Vars
    
    private var state: SettingsSceneState = .initial {
        didSet {
            view?.stateDidChange(state)
        }
    }
    
    private let userSessionService: UserSessionService
    
    weak var view: SettingsViewInput?
    
    // MARK: - Initialization
    
    init(userSessionService: UserSessionService) {
        self.userSessionService = userSessionService
    }
    
    // MARK: - Public
    
    func handleLogoutTap() {
        state = .isLogouting
        userSessionService.closeUserSessionWithCompletion {[weak self] in
            guard let strongSelf = self else {return}
            strongSelf.state = .logouted
        }
    }
}
