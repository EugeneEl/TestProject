//
//  LoginInputModel.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 10.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

struct LoginInputModel {
    
    // MARK: - Vars
    
    let email: String
    let password: String
    
    private static let minPasswordLength = 6
    
    // MARK: - Public
    
    mutating func changeEmail(_ email: String) {
        self = LoginInputModel(email: email, password: self.password)
    }
    
    mutating func changePassword(_ password: String) {
        self = LoginInputModel(email: self.email, password: password)
    }
    
    func isModelValid() -> Bool {
        return email.isValidEmail() && password.length > LoginInputModel.minPasswordLength
    }
}
