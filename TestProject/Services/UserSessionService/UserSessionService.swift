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
    
    var isLogged: Bool = false

    fileprivate let userSessionStorage: UserSessionStorage
    fileprivate let feedDataWorker: FeedDataWorker
    
    // MARK: - Initialization
    
    init?(userSessionStorage: UserSessionStorage, feedDataWorker: FeedDataWorker) {
        if !userSessionStorage.hasToken() {
            return nil
        } else {
            self.userSessionStorage = userSessionStorage
            self.feedDataWorker = feedDataWorker
        }
    }
    
    init(model: UserSessionModel, userSessionStorage: UserSessionStorage, feedDataWorker: FeedDataWorker) {
        self.userSessionStorage = userSessionStorage
        self.feedDataWorker = feedDataWorker
        self.userSessionStorage.updateCredentials(model)
    }
    
    // MARK: - Public
    
    func closeUserSessionWithCopletion(_ completion: @escaping ()->()) {
        clearDataWithCompletion {
            completion()
        }
    }
    
    // MARK: - Private
    
    private func clearDataWithCompletion(_ completion: @escaping ()->()) {
        let worker = FeedDataWorker()
        worker.deleteItems {
            self.userSessionStorage.removeCredentials()
            completion()
        }
    }
}

