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
    
    var image: UIImage {
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

struct FormInputViewUI {
    let placeholderUI: FormPlaceholderUI
    let keyboardUI: FormKeyboardUI
    let textFont: UIFont
    let isSeparatorVisible: Bool
}
