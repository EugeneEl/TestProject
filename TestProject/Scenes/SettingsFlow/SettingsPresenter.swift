//
//  SettingsPresenter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 25.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class SettingsPresenter {
    
    // MARK: - Public
    
    func handleLogoutTap() {
        UserSessionService.shared.closeUserSession()
    }
}
