//
//  SecureStorageService.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.05.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

protocol SecureStorageService {
    
    func updateObject(_ object: AnyObject, forKey: String)
    
    func readObjectForKey(_ key: String) -> AnyObject?
    
    func deleteObjectForKey(_ key: String)
}
