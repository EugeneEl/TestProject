//
//  UserSessionService.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 28.03.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

enum UserSessionState {
    case opened(UserSession)
    case closed(UserSession)
}

protocol UserSessionServiceDelegate: class {
    func userSessionStateDidChange( _ userSessionState: UserSessionState)
}

final class UserSessionService {
    
    // MARK: - Vars
    
    private var delegates = NSHashTable<AnyObject>.weakObjects()
    
    fileprivate (set) internal var userSessionIdentifier: String?
    fileprivate let authWorker = AuthWorker()
    
    // MARK: - UserSession
    private (set) var userSession: UserSession? {
        didSet {
            oldValue?.closeSession()
            userSessionIdentifier = userSession?.identifier
        }
    }
    
    fileprivate let userSessionStorage: UserSessionStorage

    // MARK: - Initialization
    
    init(userSessionStorage: UserSessionStorage) {
        self.userSessionStorage = userSessionStorage
    }
    
    func isUserSessionRestored() -> Bool {
        if let token = userSessionStorage.provideToken() {
            let session = UserSession(identifier: token)
            userSession = session
            return true
        } else {
            return false
        }
    }
    
    func addListener(_ listener: UserSessionServiceDelegate) {
        delegates.add(listener)
    }
    
    func openUserSessionWithModel(_ model: LoginInputModel, success: @escaping AuthCompletionSuccess, failure: @escaping AuthCompletionFailure) {
        authWorker.authUserWithFlow(.login(model), success: {[weak self] (authFlow, user) in
            guard let strongSelf = self else {return}
            let session = UserSession(identifier: user.identifier)
            strongSelf.userSession = session
            strongSelf.userSessionStorage.updateSessionID(user.identifier)
            strongSelf.delegates.allObjects.forEach { delegate in
                if let listener = delegate as? UserSessionServiceDelegate {
                    listener.userSessionStateDidChange(.opened(session))
                }
            }
            success(authFlow, user)
        }) {[weak self] (authFlow, errorText) in
            failure(authFlow, errorText)
        }
    }
    
    // MARK: - Public
    
    func closeUserSessionWithCompletion(_ completion: @escaping ()->()) {
        if let session = userSession {
            userSessionStorage.removeCredentials()
            delegates.allObjects.forEach { delegate in
                if let listener = delegate as? UserSessionServiceDelegate {
                    listener.userSessionStateDidChange(.closed(session))
                }
            }
            userSession = nil
        }
    }
}

