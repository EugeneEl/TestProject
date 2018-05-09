//
//  UserSessionService.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 28.03.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class UserSessionService {
    
    // MARK: - Vars
    
    static let shared = UserSessionService()
    
    var isLogged: Bool = false
    fileprivate (set) internal var sessionModel: UserSessionModel?
    fileprivate let userSessionStorage = UserSessionStorage()
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Public
    
    func openUserSessionWithModel(_ model: UserSessionModel) {
        userSessionStorage.updateCredentials(model)
        isLogged = true
    }
    
    func closeUserSession() {
        
    }
    
    func canRestoreUsesSession() -> Bool {
        return userSessionStorage.hasToken()
    }
}

