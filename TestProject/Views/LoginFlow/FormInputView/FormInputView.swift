//
//  FormInputView.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit
import MaterialComponents.MaterialTextFields

protocol FormInputViewConfigurating: class {
    var formTextField: UITextField {get}
    var textInputController: MDCTextInputControllerUnderline? {get}
    func setupFormInputViewWithFormUI(_ formUI: FormInputViewUI, delegate: UITextFieldDelegate?, text: String?)
}

final class FormInputView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate (set) internal var textField: MDCTextField!
    
    // MARK: - Vars
    
    fileprivate var showPasswordButton: UIButton?
    fileprivate var rightViewMode: FormInputRightViewMode?
    
    fileprivate (set) internal var textInputController: MDCTextInputControllerUnderline?
    
    // MARK: - Constants
    
    private static let errorAdditionalOffset: CGFloat = -10
    
    // MARK: - Public
    
    // MARK: - Private
    
    fileprivate func setupTextFieldWithFormUI(_ formUI: FormInputViewUI) {
        setupTextFieldKeyboardUI(formUI.keyboardUI)
        switch formUI.textFieldType {
        case .floating(let attributes):
            setupFloatingTextFieldAttributes(attributes, placeholderText: formUI.placeholderText)
        }
    }
    
    fileprivate func setupFloatingTextFieldAttributes(_ attributes: FloatingTextFieldAttribute, placeholderText: String) {
        textInputController = MDCTextInputControllerUnderline(textInput: textField)
        
        textInputController?.borderFillColor = .clear
        
        textInputController?.activeColor = attributes.activeInputLineColor
        
        // setup placeholder when not floating
        textInputController?.inlinePlaceholderColor = attributes.inactivePlaceholder.color
        textInputController?.inlinePlaceholderFont = attributes.activePlaceholder.font
        
        // hack for moving up errorLabel in MDCTextField
        increaseErrorLabelBottomSpace()
        
        // active vertical placeholder when floating
        textInputController?.floatingPlaceholderActiveColor = attributes.activePlaceholder.color
        
        // text ui
        textInputController?.textInputFont = attributes.textInput.font
        textField.textColor = attributes.textInput.color
        textInputController?.isFloatingEnabled = true
        
        textInputController?.placeholderText = placeholderText
    }
    
    fileprivate func setupTextFieldKeyboardUI(_ keyboardUI: FormKeyboardUI) {
        textField.keyboardType = keyboardUI.keyboardType
        textField.autocorrectionType = keyboardUI.autocorrectionType
        textField.autocapitalizationType = keyboardUI.capitalizationType
        
        setupSecureEntry(keyboardUI.isSecureTextEntry)
    }
    
    fileprivate func setupSecureEntry(_ isSecureEntry: Bool) {
        guard isSecureEntry == true else {return}
        textField.isSecureTextEntry = isSecureEntry
        
        if isSecureEntry {
            let button = UIButton()
            let mode = FormInputRightViewMode.showPassword(true)
            
            button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 36, height: 32)
            button.setImage(mode.image, for: .normal)
            
            showPasswordButton = button
            rightViewMode = mode
            textField.trailingView = showPasswordButton
            textField.trailingViewMode = .always
        }
    }
    
    @objc fileprivate func showPassword() {
        guard let mode = rightViewMode else {
            return
        }
        switch mode {
        case .showPassword(var isVisible):
            isVisible.toggle()
            
            textField.isSecureTextEntry = isVisible
            if !textField.isFirstResponder {
                textField.resignFirstResponder()
                textField.becomeFirstResponder()
            }
            
            rightViewMode = .showPassword(isVisible)
            showPasswordButton?.setImage(rightViewMode?.image, for: .normal)
        }
    }
}

// MARK: - FormInputViewConfigurating

extension FormInputView: FormInputViewConfigurating {
    var formTextField: UITextField {
        return textField
    }
    
    func setupFormInputViewWithFormUI(_ formUI: FormInputViewUI, delegate: UITextFieldDelegate?, text: String?) {
        textField.delegate = delegate
        setupTextFieldWithFormUI(formUI)
        textField.text = text
    }
}

// MARK: - FormInputView hacks

private extension FormInputView {
    func increaseErrorLabelBottomSpace() {
        // try to find errorLabel
        if let label = textField.value(forKey: "leadingUnderlineLabel") as? UILabel {
            // iterate through errorLabel's superView constraints
            if let errorLabelSuperviewConstraints = label.superview?.constraints {
                for constraint in errorLabelSuperviewConstraints {
                    if constraint.secondAttribute == .bottom {
                        if constraint.firstItem === label {
                            constraint.constant = FormInputView.errorAdditionalOffset
                        }
                    }
                }
            }
        }
    }
}
