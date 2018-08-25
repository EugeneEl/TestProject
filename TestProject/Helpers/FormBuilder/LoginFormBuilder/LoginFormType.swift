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

/// Form types for composing Login Screen.
enum LoginFormType {
    case email
    case password
    
    // MARK: - Constants
    
    private static let font = UIFont.systemFont(ofSize: 15)
    private static let rightOffset: CGFloat = 8
    private static let leftOffset: CGFloat = 8
    
    private static let emailPlaceholderUI = FormPlaceholderUI(text: "Email",
                                                              rightPadding: 8,
                                                              leftPadding: 8,
                                                              width: 80);
    
    private static let passwordPlaceholderUI = FormPlaceholderUI(text: "Password",
                                                                 rightPadding: 8,
                                                                 leftPadding: 8,
                                                                 width: 80);
    
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
        switch self {
        case .email:
            return FormInputViewUI(placeholderUI: LoginFormType.emailPlaceholderUI,
                                   keyboardUI: keyboardUI,
                                   textFont: LoginFormType.font,
                                   isSeparatorVisible: true)
        case .password:
            return FormInputViewUI(placeholderUI: LoginFormType.passwordPlaceholderUI,
                                   keyboardUI: keyboardUI,
                                   textFont: LoginFormType.font,
                                   isSeparatorVisible: false)
            
        }
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
}
