//
//  User.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 02.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

struct User {
    let identifier: String
    let email: String?
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    
    private struct SerializationKeys {
        static let identifier = "identifier"
        static let email = "email"
    }
    
    init?(json: JSON) {
        guard let id = json[User.SerializationKeys.identifier].string else {
            return nil
        }
        self.identifier = id
        self.email = json[User.SerializationKeys.email].string
    }
}

extension User {
    init?(entity: UserEntity) {
        guard let id = entity.identifier else {
            return nil
        }
        self.identifier = id
        self.email = entity.email
    }
}
