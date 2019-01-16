//
//  InputFormUI.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 25.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

enum FormInputRightViewMode {
    case showPassword(Bool)
    
    var image: UIImage? {
        switch self {
        case .showPassword(let isVisible):
            if isVisible {
                return #imageLiteral(resourceName: "showPassword")
            } else {
                return #imageLiteral(resourceName: "hidePassword")
            }
        }
    }
}

struct FormKeyboardUI {
    let keyboardType: UIKeyboardType
    let capitalizationType: UITextAutocapitalizationType
    let autocorrectionType: UITextAutocorrectionType
    let isSecureTextEntry: Bool
}

struct FormPlaceholderUI {
    let text: String
    let rightPadding: CGFloat
    let leftPadding: CGFloat
    let width: CGFloat
}

struct FloatingPlaceholderAttribute {
    let color: UIColor
    let font: UIFont
}

struct FloatingTextFieldAttribute {
    let activeInputLineColor: UIColor
    let activePlaceholder: FloatingPlaceholderAttribute
    let inactivePlaceholder: FloatingPlaceholderAttribute
    let textInput: FloatingPlaceholderAttribute
}

enum TextFieldType {
    case floating(attribute: FloatingTextFieldAttribute)
}

struct FormInputViewUI {
    let textFieldType: TextFieldType
    let keyboardUI: FormKeyboardUI
    let placeholderText: String
}
