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
    func textDidChangeInForm(_ text: String)
 }
 
 final class FormInputConroller: NSObject {
    
    // MAKR: - Vars
    
    private let formConfigurating: FormInputViewConfigurating
    weak var delegate: FormInputConrollerOutput?
    
    // MARK: - Initialization
    
    init(formConfigurating: FormInputViewConfigurating, formInputViewUI: FormInputViewUI) {
        self.formConfigurating = formConfigurating
        super.init()
        self.formConfigurating.setupFormInputViewWithFormUI(formInputViewUI, delegate: self)
    }
}

 // MARK: - UITextFieldDelegate
 
 extension FormInputConroller: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        var txtAfterUpdate:NSString = textField.text! as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        
        delegate?.textDidChangeInForm(txtAfterUpdate as String)
        
        return true
    }
 }
