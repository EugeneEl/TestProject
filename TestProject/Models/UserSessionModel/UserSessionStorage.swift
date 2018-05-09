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
    
    func updateCredentials(_ userSessionModel: UserSessionModel) {
        secureStorage.updateObject(userSessionModel.token as AnyObject, forKey: UserSessionStorage.tokenKey)
    }
    
    func hasToken() -> Bool {
        return secureStorage.readObjectForKey(UserSessionStorage.tokenKey) != nil
    }
}
