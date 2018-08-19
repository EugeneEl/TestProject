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
}

protocol FormInputViewConfigurating: class {
    func setupFormInputViewWithFormUI(_ formUI: FormInputViewUI)
}

protocol FormInputViewOutput: class {
    func textDidChangeInForm(_ text: String)
}

final class FormInputView: UIView {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var textField: UITextField!
    
    // MARK: - Vars
    
    weak var delegate: FormInputViewOutput?
    
    // MARK: - Public
    
    // MARK: - Private
    
    fileprivate func setupTextFieldWithFormUI(_ formUI: FormInputViewUI) {
        let leftViewLabel = UILabel()
        leftViewLabel.text = formUI.placeholderText
        
        let width = leftViewLabel.intrinsicContentSize.width + formUI.placeholderRightPadding
        
        leftViewLabel.bounds = CGRect(x: 0, y: 0, width: width, height: textField.bounds.size.height)
        textField.font = formUI.textFont
        
        textField.leftViewMode = .always
        textField.leftView = leftViewLabel
    }
}

// MARK: - UITextFieldDelegate

extension FormInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var txtAfterUpdate:NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        
        delegate?.textDidChangeInForm(txtAfterUpdate as String)
        
        return true
    }
}

// MARK: - FormInputViewConfigurating

extension FormInputView: FormInputViewConfigurating {
    func setupFormInputViewWithFormUI(_ formUI: FormInputViewUI) {
        setupTextFieldWithFormUI(formUI)
    }
}