//
//  UserSessionService.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 28.03.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

struct UserSessionServiceNotification {
    static let login = NSNotification.Name(rawValue: "UserDidLogin")
    static let logout = NSNotification.Name(rawValue: "UserDidLogout")
}

final class UserSessionService {
    
    // MARK: - Vars
    
    static let shared = UserSessionService()
    
    private let nc = NotificationCenter.default
    
    var isLogged: Bool = false
    
    fileprivate (set) internal var sessionModel: UserSessionModel?
    fileprivate let userSessionStorage = UserSessionStorage()
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - Public
    
    func openUserSessionWithModel(_ model: UserSessionModel) {
        userSessionStorage.updateCredentials(model)
        isLogged = true
        nc.post(name: UserSessionServiceNotification.login, object: nil)
    }
    
    func closeUserSessionWithCopletion(_ completion: @escaping ()->()) {
        clearDataWithCompletion {
            completion()
        }
    }
    
    func canRestoreUsesSession() -> Bool {
        return userSessionStorage.hasToken()
    }
    
    // MARK: - Private
    
    private func clearDataWithCompletion(_ completion: @escaping ()->()) {
        let worker = FeedDataWorker()
        worker.deleteItems {
            self.userSessionStorage.removeCredentials()
            self.nc.post(name: UserSessionServiceNotification.logout, object: nil)
            completion()
        }
    }
}

