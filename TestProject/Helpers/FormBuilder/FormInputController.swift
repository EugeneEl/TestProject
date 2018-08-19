//
//  FormInputController.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class FormInputConroller {
    
    // MAKR: - Vars
    
    private let formConfigurating: FormInputViewConfigurating
    
    // MARK: - Initialization
    
    init(formConfigurating: FormInputViewConfigurating, formInputViewUI: FormInputViewUI) {
        self.formConfigurating = formConfigurating
        self.formConfigurating.setupFormInputViewWithFormUI(formInputViewUI)
    }
}
