//
//  LoginFormType.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 25.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

enum FormControllerType {
    case email
    case password
}

struct FormControllerConfiguration {
    let ui: FormInputViewUI
    let formType: FormControllerType
    let validators: [Validator]
}

struct FormInputAttrubutes {
    static let activePlaceholder = FloatingPlaceholderAttribute(color: Constants.Colors.lightGrey,
                                                                font: ProximaNovaFont.semibold.fontWithSize(15))
    static let inactivePlaceholder = FloatingPlaceholderAttribute(color: Constants.Colors.lightGrey,
                                                                  font: ProximaNovaFont.regular.fontWithSize(13))
    static let textInput = FloatingPlaceholderAttribute(color: .black,
                                                        font: ProximaNovaFont.semibold.fontWithSize(15))
    
    static let formUI = FloatingTextFieldAttribute(
        activeInputLineColor: Constants.Colors.grey,
        activePlaceholder: activePlaceholder,
        inactivePlaceholder: inactivePlaceholder,
        textInput: textInput
    )
}

enum LoginFormType {
    case email
    case password

    
    private static let userNameKeyboardUI = FormKeyboardUI(keyboardType: .default,
                                                           capitalizationType: .words,
                                                           autocorrectionType: .no,
                                                           isSecureTextEntry: false)
    
    private static let passwordKeyboardUI = FormKeyboardUI(keyboardType: .default,
                                                           capitalizationType: .none,
                                                           autocorrectionType: .no,
                                                           isSecureTextEntry: true)
    private static let emailKeyboardUI = FormKeyboardUI(keyboardType: .emailAddress,
                                                        capitalizationType: .none,
                                                        autocorrectionType: .no,
                                                        isSecureTextEntry: false)
    
    // MARK: Public
    
    var formUI: FormInputViewUI {
        let textFieldType = TextFieldType.floating(attribute: FormInputAttrubutes.formUI)
        return FormInputViewUI(textFieldType: textFieldType,
                               keyboardUI: keyboardUI,
                               placeholderText: hint)
    }
    
    var configuration: FormControllerConfiguration {
        switch self {
        case .password:
            return FormControllerConfiguration(ui: formUI,
                                               formType: .password,
                                               validators: FormValidators.passwordValidators)
        case .email:
            return FormControllerConfiguration(ui: formUI,
                                               formType: .email,
                                               validators: FormValidators.emailValidators)
        }
    }
    
    // MARK: - Private
    
    private var keyboardUI: FormKeyboardUI {
        switch self {
        case .email:
            return LoginFormType.emailKeyboardUI
        case .password:
            return LoginFormType.passwordKeyboardUI
        }
    }
    
    private var hint: String {
        switch self {
        case .email:
            return "login_scene_email_hint".localized
        case .password:
            return "login_scene_password_hint".localized
        }
    }
}

final class LoginFormModuleProvider {
    
    // MARK: - Public
    
    static func setupModuleForLoginFormType(_ loginFormType: LoginFormType, containerView: UIView) -> FormInputConroller {
        let formView = FormInputView.instantiateView()
        containerView.addSubview(formView)
        formView.constraintToSuperviewEdges()
        
        let formController = FormInputConroller(formConfigurating: formView, configuration: loginFormType.configuration, initalText: "")
        
        return formController
    }
}
