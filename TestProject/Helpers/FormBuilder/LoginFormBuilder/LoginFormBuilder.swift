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
    
    var formUI: FormInputViewUI {
        switch self {
        case .email:
            return FormInputViewUI(placeholderText: "Email:",
                                   formKeyboardUI: keyboardUI,
                                   textFont: UIFont.systemFont(ofSize: 15),
                                   placeholderRightPadding: 8)
        case .password:
            return FormInputViewUI(placeholderText: "Password:",
                                   formKeyboardUI: keyboardUI,
                                   textFont: UIFont.systemFont(ofSize: 15),
                                   placeholderRightPadding: 8)
        }
    }
    
    var keyboardUI: FormKeyboardUI {
        switch self {
        case .email:
            return FormKeyboardUI(keyboardType: .emailAddress,
                                  capitalizationType: .none,
                                  autocorrectionType: .no)
        case .password:
            return FormKeyboardUI(keyboardType: .default,
                                  capitalizationType: .none,
                                  autocorrectionType: .no)
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
