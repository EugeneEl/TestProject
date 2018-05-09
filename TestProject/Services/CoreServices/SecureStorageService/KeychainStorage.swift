//
//  KeychainStorage.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.05.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import FXKeychain

class KeychainSecureStorage: SecureStorageService {
    
    // MARK: - Vars
    
    static let sharedSecureStorage = KeychainSecureStorage()
    fileprivate let keychain = FXKeychain.default()
    
    // MARK: - Initialization
    
    private init() {}
    
    // MARK: - SecureStorageService
    
    func updateObject(_ object: AnyObject, forKey key: String) {
        keychain.accessibility = .accessibleAlways
        keychain.setObject(object, forKey: key)
    }
    
    func readObjectForKey(_ key: String) -> AnyObject? {
        keychain.accessibility = .accessibleAlways
        return keychain.object(forKey: key) as AnyObject?
    }
    
    func deleteObjectForKey(_ key: String) {
        keychain.accessibility = .accessibleAlways
        keychain.removeObject(forKey: key)
    }
}
