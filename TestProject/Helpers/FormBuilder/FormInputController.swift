 //
//  FormInputController.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

 protocol FormInputConrollerOutput: class {
    func textDidChangeInForm(_ text: String, formType: FormControllerType)
 }
 
 final class FormInputConroller: NSObject {
    
    // MAKR: - Vars
    
    private let formConfigurating: FormInputViewConfigurating
    private let formType: FormControllerType
    fileprivate (set) internal var text: String?
    
    weak var delegate: FormInputConrollerOutput?
    
    // MARK: - Initialization
    
    init(formConfigurating: FormInputViewConfigurating, formInputViewUI: FormInputViewUI, formType: FormControllerType, initalText: String?) {
        self.formConfigurating = formConfigurating
        self.formType = formType
        self.text = initalText
        super.init()
        self.formConfigurating.setupFormInputViewWithFormUI(formInputViewUI, delegate: self, text: initalText)
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
 }
