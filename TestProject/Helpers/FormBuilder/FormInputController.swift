 //
//  FormInputController.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

 protocol FormInputConrollerOutput: class {
    func textDidChangeInForm(_ text: String)
 }
 
final class FormInputConroller {
    
    // MAKR: - Vars
    
    private let formConfigurating: FormInputViewConfigurating
    weak var delegate: FormInputConrollerOutput?
    
    // MARK: - Initialization
    
    init(formConfigurating: FormInputViewConfigurating, formInputViewUI: FormInputViewUI) {
        self.formConfigurating = formConfigurating
        self.formConfigurating.setupFormInputViewWithFormUI(formInputViewUI)
    }
}

// MARK: - FormInputViewOutput

extension FormInputConroller: FormInputViewOutput {
    func textDidChangeInForm(_ text: String) {
        delegate?.textDidChangeInForm(text)
    }
}
