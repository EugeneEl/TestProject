//
//  UserSessionService.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 28.03.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class UserSession {
    
//    let user: User
    let identifier: String
    
    // MARK: - Initialization
    
    init(identifier: String) {
//        self.user = user
        self.identifier = identifier
    }
}

final class UserSessionService {
    
    // MARK: - Vars
    
    fileprivate (set) internal var userSessionIdentifier: String?
    
    // MARK: - UserSession
    private (set) var userSession: UserSession? {
        didSet {
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
    
//    init(model: UserSessionModel, userSessionStorage: UserSessionStorage, feedDataWorker: FeedDataWorker) {
//        self.userSessionStorage = userSessionStorage
//        self.userSessionStorage.updateCredentials(model)
//    }
    
    // MARK: - Public
    
    func closeUserSessionWithCompletion(_ completion: @escaping ()->()) {
//        clearDataWithCompletion {
//            completion()
//        }
    }
    
    // MARK: - Private
//
//    private func clearDataWithCompletion(_ completion: @escaping ()->()) {
//        let worker = FeedDataWorker()
//        worker.deleteItems {
//            self.userSessionStorage.removeCredentials()
//            completion()
//        }
//    }
}

