//
//  FormInputView.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

struct FormKeyboardUI {
    let keyboardType: UIKeyboardType
    let capitalizationType: UITextAutocapitalizationType
    let autocorrectionType: UITextAutocorrectionType
    let isSecureTextEntry: Bool
}

struct FormInputViewUI {
    let placeholderText: String
    let formKeyboardUI: FormKeyboardUI
    let textFont: UIFont
    let placeholderRightPadding: CGFloat
    let placeholderLeftPadding: CGFloat
    let isSeparatorVisible: Bool
}

protocol FormInputViewConfigurating: class {
    func setupFormInputViewWithFormUI(_ formUI: FormInputViewUI, delegate: UITextFieldDelegate)
}

final class FormInputView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var textField: UITextField!
    @IBOutlet fileprivate weak var leftPaddingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var separatorView: UIView!
    
    // MARK: - Public
    
    // MARK: - Private
    
    fileprivate func setupTextFieldWithFormUI(_ formUI: FormInputViewUI) {
        let leftViewLabel = UILabel()
        leftViewLabel.text = formUI.placeholderText
        
        let width = leftViewLabel.intrinsicContentSize.width + formUI.placeholderRightPadding
        leftViewLabel.bounds = CGRect(x: 0, y: 0, width: width, height: textField.bounds.size.height)
        textField.font = formUI.textFont
        leftPaddingConstraint.constant = formUI.placeholderLeftPadding
        
        textField.isSecureTextEntry = formUI.formKeyboardUI.isSecureTextEntry
        textField.leftViewMode = .always
        textField.leftView = leftViewLabel
    }
}

// MARK: - FormInputViewConfigurating

extension FormInputView: FormInputViewConfigurating {
    func setupFormInputViewWithFormUI(_ formUI: FormInputViewUI, delegate: UITextFieldDelegate) {
        textField.delegate = delegate
        setupTextFieldWithFormUI(formUI)
        separatorView.isHidden = !formUI.isSeparatorVisible
    }
}
