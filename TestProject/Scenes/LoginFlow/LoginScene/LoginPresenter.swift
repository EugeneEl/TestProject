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

protocol LoginViewInput: class {
    func loginStateDidChange(_ state: LoginSceneState)
}

final class LoginPresenter: LoginViewOutput {
    
    // MARK: - Vars
    
    weak var view: LoginViewInput?
    
    let formTypes = [LoginFormType.email, LoginFormType.password]
    var inputControllers: [FormInputConroller] = []
    
    fileprivate (set) internal var model: LoginInputModel
    fileprivate (set) internal var loginState: LoginSceneState  {
        didSet {
            view?.loginStateDidChange(loginState)
        }
    }
    
    fileprivate let userSessionService: UserSessionService
    
    // MARK: - Initialization
    
    init(userSessionService: UserSessionService, model: LoginInputModel) {
        self.model = model
        self.userSessionService = userSessionService
        self.loginState = .loginInput(model)
    }
    
    // MARK: - Public
    
    func loginDidTap() {
        loginState = .isLogging
//        userSessionService.openUserSessionWithModel(model, success: {[weak self] (flow, user) in
//            guard let strongSelf = self else {return}
//            strongSelf.loginState = .loginSuccess
//        }) {[weak self] (flow, errorText) in
//            guard let strongSelf = self else {return}
//            strongSelf.loginState = .loginFail(error: errorText)
//        }
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
    func textFieldDoneDidTapInFormType(_ formType: FormControllerType) {
        
    }
    
    func textDidChangeInForm(_ text: String, formType: FormControllerType) {
        switch formType {
        case .email:
            updateEmail(text)
        case .password:
            updatePassword(text)
        }
    }
}
