//
//  UserSessionStorage.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.05.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class UserSessionStorage {
    
    // MARK: - Vars
    
    fileprivate let secureStorage: SecureStorageService = ServiceLocator.inject()
    fileprivate static let tokenKey = "TestProject.tokenKey"
    
    // MARK: - Public
    
    func updateSessionID(_ sessionID: String) {
        secureStorage.updateObject(sessionID as AnyObject, forKey: UserSessionStorage.tokenKey)
    }
    
    func hasToken() -> Bool {
        return secureStorage.readObjectForKey(UserSessionStorage.tokenKey) != nil
    }
    
    func provideToken() -> String? {
        return secureStorage.readObjectForKey(UserSessionStorage.tokenKey) as? String
    }
    
    func removeCredentials() {
        secureStorage.deleteObjectForKey(UserSessionStorage.tokenKey)
    }
}
