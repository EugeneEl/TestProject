 //
//  FormInputController.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

 import Foundation
 import UIKit
 import MaterialComponents.MaterialTextFields
 
 protocol FormInputConrollerOutput: class {
    func textDidChangeInForm(_ text: String, formType: FormControllerType)
    func textFieldDoneDidTapInFormType(_ formType: FormControllerType)
 }
 
 protocol FormControllerEditingOutput: class {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
 }
 
 final class FormInputConroller: NSObject {
    
    // MAKR: - Vars
    
    private let formView: FormInputViewConfigurating
    private let formType: FormControllerType
    fileprivate (set) internal var text: String?
    fileprivate let validators: [Validator]
    
    weak var editingOutput: FormControllerEditingOutput?
    weak var delegate: FormInputConrollerOutput?
    
    var textField: UITextField {
        return formView.formTextField
    }
    
    // MARK: - Initialization
    
    init(formConfigurating: FormInputViewConfigurating, configuration: FormControllerConfiguration, initalText: String?) {
        self.formView = formConfigurating
        self.formType = configuration.formType
        self.text = initalText
        self.validators = configuration.validators
        super.init()
        self.formView.setupFormInputViewWithFormUI(configuration.ui, delegate: self, text: initalText)
    }
 }
 
 // MARK: - UITextFieldDelegate
 
 extension FormInputConroller: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var txtAfterUpdate:NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        
        delegate?.textDidChangeInForm(txtAfterUpdate as String, formType: formType)
        
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        formView.textInputController?.setErrorText(nil, errorAccessibilityValue: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let currentText = textField.text, currentText.count > 0 else {return}
        if let validationError = validators.flatMap({return $0.validationErrorForText(text: currentText)}).first {
            formView.textInputController?.setErrorText(validationError, errorAccessibilityValue: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            delegate?.textFieldDoneDidTapInFormType(formType)
        }
        editingOutput?.textFieldShouldReturn(textField)
        return true
    }
 }
