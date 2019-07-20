//
//  SignInPresenter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 23.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation

enum SignInSceneState {
    case initial
    case loginRequest(RequestState<Void>)
}

protocol SignInViewInput: class {
    func loginStateDidChange(_ state: SignInSceneState)
}

final class SignInPresenter {
    
    // MARK: - Vars
    
    weak var view: SignInViewInput?
    
    fileprivate var inputControllers = [FormInputConroller]()
    fileprivate (set) internal var model: SignInModel = SignInModel(email: "", password: "")
    fileprivate (set) internal var loginState: SignInSceneState = .initial {
        didSet {
            view?.loginStateDidChange(loginState)
        }
    }
    
    private let userSessionService: UserSessionService
    
    // MARK: - Initialization
    
    init(userSessionService: UserSessionService) {
        self.userSessionService = userSessionService
    }
    
    // MARK: - Public
    
    func addInputController(_ inputController: FormInputConroller) {
        inputControllers.append(inputController)
        inputController.delegate = self
    }
    
    func loginDidTap() {
        if let errorText = model.validateModel() {
            loginState = .loginRequest(.failure(nil, errorText, nil))
            return
        }
        loginState = .loginRequest(.isLoading)
        userSessionService.openUserSessionWithModel(model, success: {[weak self] (flow, user) in
            guard let strongSelf = self else {return}
            strongSelf.loginState =  .loginRequest(.success(()))
        }) {[weak self] (flow, errorText) in
            guard let strongSelf = self else {return}
            strongSelf.loginState = .loginRequest(.failure(nil, errorText, nil))
        }
    }
}

// MARK: - FormInputConrollerOutput

extension SignInPresenter: FormInputConrollerOutput {
    func textFieldDoneDidTapInFormType(_ formType: FormControllerType) {
        //handleSignInTap()
    }
    
    func textDidChangeInForm(_ text: String, formType: FormControllerType) {
        switch formType {
        case .email:
            model.email = text
        case .password:
            model.password = text
        default: break
        }
    }
}

struct SignInModel {
    
    // MARK: - Vars
    
    var email: String
    var password: String
    
    // MARK: - Constants
    
    private struct SerializationKeys {
        static let email = "email"
        static let password = "password"
    }
    
    fileprivate static let emailValidators = FormValidators.emailValidators
    fileprivate static let passwordValidators = FormValidators.passwordValidators
    
    // MARK: - Public
    
    func validateModel() -> String? {
        let emailError = SignInModel.emailValidators.compactMap({return $0.validationErrorForText(text: email)})
        let passwordError = SignInModel.passwordValidators.compactMap({return $0.validationErrorForText(text: password)})
        
        let errors = emailError + passwordError
        return errors.first
    }
    
    func convertToJSON() -> [String : AnyObject] {
        var parameters = [String : AnyObject]()
        
        parameters[SerializationKeys.email] = email as AnyObject
        parameters[SerializationKeys.password] = password as AnyObject
        
        return parameters
    }
}
