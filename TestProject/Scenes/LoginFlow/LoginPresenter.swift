//
//  LoginPresenter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 08.04.2018.
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
        return true
    }
}

enum LoginSceneState {
    case loginInput(PasswordInputModel)
    case isLogging
    case loginSuccess
    case loginFail(error: String)
}

protocol LoginPresenterOutput: class {
    func loginStateDidChange(_ state: LoginSceneState)
}

final class LoginPresenter {
    
    // MARK: - Vars
    
    weak var output: LoginPresenterOutput?
    
    fileprivate (set) internal var model: PasswordInputModel
    fileprivate (set) internal var loginState: LoginSceneState {
        didSet {
            output?.loginStateDidChange(loginState)
        }
    }
    
    // MARK: - Initialization
    
    init() {
        let initialModel = PasswordInputModel(email: "", password: "")
        self.model = initialModel
        self.loginState = LoginSceneState.loginInput(initialModel)
    }
    
    // MARK: - Public
    
    func updateEmail(_ email: String) {
        model.changeEmail(email)
        loginState = LoginSceneState.loginInput(model)
    }
    
    func updatePassword(_ password: String) {
        model.changeEmail(email)
        loginState = LoginSceneState.loginInput(model)
    }
    
    func loginDidTap() {
        loginState = .isLogging
    }
}
