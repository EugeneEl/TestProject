//
//  FormInputView.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

protocol FormInputViewConfigurating: class {
    func setupFormInputViewWithFormUI(_ formUI: FormInputViewUI, delegate: UITextFieldDelegate)
}

final class FormInputView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var textField: UITextField!
    @IBOutlet fileprivate weak var leftPaddingConstraint: NSLayoutConstraint!
    @IBOutlet fileprivate weak var separatorView: UIView!
    
    // MARK: - Vars
    
    fileprivate var showPasswordButton: UIButton?
    fileprivate var rightViewMode: FormInputRightViewMode?
    
    // MARK: - Public
    
    // MARK: - Private
    
    fileprivate func setupTextFieldWithFormUI(_ formUI: FormInputViewUI) {
        let leftViewLabel = UILabel()
        leftViewLabel.text = formUI.placeholderUI.text
        
        let leftPadding = formUI.placeholderUI.leftPadding
        let rightPadding = formUI.placeholderUI.rightPadding
        let placeholderWidth = formUI.placeholderUI.width
        
        let width = placeholderWidth + rightPadding
        leftViewLabel.bounds = CGRect(x: 0, y: 0, width: width, height: textField.bounds.size.height)
        textField.font = formUI.textFont
        leftPaddingConstraint.constant = leftPadding

        setupSecureEntry(formUI.keyboardUI.isSecureTextEntry)
        
        textField.keyboardType = formUI.keyboardUI.keyboardType
        textField.autocorrectionType = formUI.keyboardUI.autocorrectionType
        textField.autocapitalizationType = formUI.keyboardUI.capitalizationType
        textField.leftViewMode = .always
        textField.leftView = leftViewLabel
    }
    
    fileprivate func setupSecureEntry(_ isSecureEntry: Bool) {
        textField.isSecureTextEntry = isSecureEntry
        
        if isSecureEntry {
            let button = UIButton()
            let mode = FormInputRightViewMode.showPassword(true)

            button.addTarget(self, action: #selector(showPassword), for: .touchUpInside)
            button.frame = CGRect(x: 0, y: 0, width: 36, height: 32)
            button.setImage(mode.image, for: .normal)
            
            showPasswordButton = button
            rightViewMode = mode
            textField.rightViewMode = .always
            textField.rightView = showPasswordButton
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
            if textField.isFirstResponder {
                textField.becomeFirstResponder()
            }
            
            // refresh cursor fix after isSecureEntry
            let currentText = textField.text
            textField.text = ""
            textField.text = currentText
            rightViewMode = .showPassword(isVisible)
            showPasswordButton?.setImage(rightViewMode?.image, for: .normal)
        }
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
