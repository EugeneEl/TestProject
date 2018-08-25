//
//  LoginFormBuilder.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 19.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

final class LoginFormBuilder {
    
    /// Provide an input control and view for login screen.
    ///
    /// - Parameters:
    ///   - formType: `LoginFormType` type.
    /// - Returns: A tuple with `FormInputConroller` inputControl (contains input logic) and `UIView` instance for form.
    static func provideInputControlModuleForFragment(_ formType: LoginFormType) -> (FormInputConroller, UIView) {
        
        let view = FormInputView.instantiateView()
        let inputControl = FormInputConroller(formConfigurating: view, formInputViewUI: formType.formUI, formType: formType.formControllerType)
        
        return (inputControl, view)
    }
}
