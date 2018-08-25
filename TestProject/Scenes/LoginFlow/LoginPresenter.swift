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
    
    fileprivate (set) internal var model: LoginInputModel = LoginInputModel(email: "", password: "")
    fileprivate (set) internal var loginState: LoginSceneState = .loginInput(LoginInputModel(email: "", password: "")) {
        didSet {
            output?.loginStateDidChange(loginState)
        }
    }
    
    // MARK: - Public
    
    func loginDidTap() {
        loginState = .isLogging
        let userSessionModel = UserSessionModel(email: model.email, password: model.password)
        UserSessionService.shared.openUserSessionWithModel(userSessionModel)
        loginState = .loginSuccess
    }
    
    // MAKR: - Private
    
    fileprivate func updateEmail(_ email: String) {
        model.changeEmail(email)
        loginState = LoginSceneState.loginInput(model)
    }
    
    fileprivate func updatePassword(_ password: String) {
        model.changePassword(password)
        loginState = LoginSceneState.loginInput(model)
    }
}

// MARK: - FormInputConrollerOutput

extension LoginPresenter: FormInputConrollerOutput {
    func textDidChangeInForm(_ text: String, formType: FormControllerType) {
        switch formType {
        case .email:
            updateEmail(text)
        case .password:
            updatePassword(text)
        }
    }
}
