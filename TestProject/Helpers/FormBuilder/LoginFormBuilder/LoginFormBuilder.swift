//
//  LoginFormBuilder.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

enum FormControllerType {
    case email
    case password
}

/// Form types for composing Login Screen.
enum LoginFormType {
    case email
    case password
    
    // MARK: - Constants
    
    private static let font = UIFont.systemFont(ofSize: 15)
    private static let rightOffset: CGFloat = 8
    private static let leftOffset: CGFloat = 8
    
    private static let emailKeyboardUI = FormKeyboardUI(keyboardType: .emailAddress,
                                                        capitalizationType: .none,
                                                        autocorrectionType: .no,
                                                        isSecureTextEntry: false)
    private static let passwordKeyboardUI = FormKeyboardUI(keyboardType: .default,
                                                        capitalizationType: .none,
                                                        autocorrectionType: .no,
                                                        isSecureTextEntry: true)
    
    static let inputHeight: CGFloat = 44
    
    // MARK: - Vars
    // MARK: - Public
    
    var formUI: FormInputViewUI {
        return FormInputViewUI(placeholderText: placeholderText,
                                   formKeyboardUI: keyboardUI,
                                   textFont: LoginFormType.font,
                                   placeholderRightPadding: LoginFormType.rightOffset,
                                   placeholderLeftPadding: LoginFormType.leftOffset)
    }
    
    var formControllerType: FormControllerType {
        switch self {
        case .email:
            return .email
        case .password:
            return .password
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
    
    private var placeholderText: String {
        switch self {
        case .email:
            return "Email:"
        case .password:
            return "Password:"
        }
    }
}

final class LoginFormBuilder {
    
    /// Provide an input control and view for login screen.
    ///
    /// - Parameters:
    ///   - formType: `LoginFormType` type.
    /// - Returns: A tuple with `FormInputConroller` inputControl (contains input logic) and `UIView` instance for form.
    static func provideInputControlModuleForFragment(_ formType: LoginFormType) -> (FormInputConroller, UIView) {
        
        let view = FormInputView.instantiateView()
        let inputControl = FormInputConroller(formConfigurating: view, formInputViewUI: formType.formUI, formType: formType.formControllerType)
        
        return (inputControl, view)
    }
}
