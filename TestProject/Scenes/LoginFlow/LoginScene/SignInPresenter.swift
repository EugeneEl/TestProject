//
//  SignInPresenter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 23.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class SignInPresenter {
    
    // MARK: - Vars
    
    fileprivate var inputControllers = [FormInputConroller]()
    fileprivate (set) internal var model: SignInModel = SignInModel(email: "", password: "")
    
    // MARK: - Initialization
    
    init() {
        
    }
    
    // MARK: - Public
    
    func addInputController(_ inputController: FormInputConroller) {
        inputControllers.append(inputController)
        inputController.delegate = self
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
        let emailError = SignInModel.emailValidators.flatMap({return $0.validationErrorForText(text: email)})
        let passwordError = SignInModel.passwordValidators.flatMap({return $0.validationErrorForText(text: password)})
        
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
