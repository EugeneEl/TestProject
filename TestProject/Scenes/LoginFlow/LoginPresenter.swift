//
//  LoginPresenter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 08.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

/**
 LoginScene states.
 ````
 case loginInput(LoginInputModel)
 case isLogging
 case loginSuccess
 case loginFail(error: String)
 ````
 */
enum LoginSceneState {
    case loginInput(LoginInputModel)
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
    
    let formTypes = [LoginFormType.email, LoginFormType.password]
    var inputControllers: [FormInputConroller] = []
    
    fileprivate (set) internal var model: LoginInputModel
    fileprivate (set) internal var loginState: LoginSceneState {
        didSet {
            output?.loginStateDidChange(loginState)
        }
    }
    
    // MARK: - Initialization
    
    init() {
        let initialModel = LoginInputModel(email: "", password: "")
        self.model = initialModel
        self.loginState = LoginSceneState.loginInput(initialModel)
    }
    
    // MARK: - Public
    
    /// Trigger initial state for scene. In more complicated implementations we can want to retrieve saved email from keychain for login etc.
    func triggerInitialState() {
        loginState = LoginSceneState.loginInput(model)
    }
    
    func updateEmail(_ email: String) {
        model.changeEmail(email)
        loginState = LoginSceneState.loginInput(model)
    }
    
    func updatePassword(_ password: String) {
        model.changePassword(password)
        loginState = LoginSceneState.loginInput(model)
    }
    
    func loginDidTap() {
        loginState = .isLogging
        let userSessionModel = UserSessionModel(email: model.email, password: model.password)
        UserSessionService.shared.openUserSessionWithModel(userSessionModel)
        loginState = .loginSuccess
    }
}
