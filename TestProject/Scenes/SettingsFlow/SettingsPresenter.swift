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
    
    private let userSessionService: UserSessionService
    
    weak var output: SettingsPresenterOutput?
    
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
