//
//  LoginFormBuilder.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

/// Form types for composing Login Screen.
enum LoginFormType {
    case email
    case password
    
    // MARK: - Vars
    
    private static let font = UIFont.systemFont(ofSize: 15)
    private static let offset: CGFloat = 8
    
    // MARK: - Public
    
    var formUI: FormInputViewUI {
        return FormInputViewUI(placeholderText: placeholderText,
                                   formKeyboardUI: keyboardUI,
                                   textFont: LoginFormType.font,
                                   placeholderRightPadding: LoginFormType.offset)
    }
    
    // MARK: - Private
    
    private var keyboardUI: FormKeyboardUI {
        switch self {
        case .email:
            return FormKeyboardUI(keyboardType: .emailAddress,
                                  capitalizationType: .none,
                                  autocorrectionType: .no,
                                  isSecureTextEntry: false)
        case .password:
            return FormKeyboardUI(keyboardType: .default,
                                  capitalizationType: .none,
                                  autocorrectionType: .no,
                                  isSecureTextEntry: true)
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
        let inputControl = FormInputConroller(formConfigurating: view, formInputViewUI: formType.formUI)
        
        return (inputControl, view)
    }
}
