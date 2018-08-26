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
    fileprivate (set) internal var loginState: LoginSceneState  {
        didSet {
            output?.loginStateDidChange(loginState)
        }
    }
    
    // MARK: - Initialization
    
    init() {
        let testModel = LoginInputModel(email: "testmail@gmail.com", password: "123456")
        self.model = testModel
        self.loginState = .loginInput(testModel)
    }
    
    // MARK: - Public
    
    func loginDidTap() {
        loginState = .isLogging
        let userSessionModel = UserSessionModel(email: model.email, password: model.password)
        UserSessionService.shared.openUserSessionWithModel(userSessionModel)
        loginState = .loginSuccess
    }
    
    func provideTextForForm(_ form: LoginFormType) -> String {
        switch form {
        case .email:
            return model.email
        case .password:
            return model.password
        }
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
