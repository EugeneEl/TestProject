//
//  PasswordInputModel.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 10.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

struct PasswordInputModel {
    let email: String
    let password: String
    
    mutating func changeEmail(_ email: String) {
        self = PasswordInputModel(email: email, password: self.password)
    }
    
    mutating func changePassword(_ password: String) {
        self = PasswordInputModel(email: self.email, password: password)
    }
    
    func isModelValid() -> Bool {
        return email.isValidEmail() && password.length > 6
    }
}
