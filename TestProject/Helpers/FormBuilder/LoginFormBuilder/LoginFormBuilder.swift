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
    static func provideInputControlModuleForFragment(_ formType: LoginFormType, initalText: String) -> (FormInputConroller, UIView) {
        
        let view = FormInputView.instantiateView()
        let inputControl = FormInputConroller(formConfigurating: view, formInputViewUI: formType.formUI, formType: formType.formControllerType, initalText: initalText)
        
        return (inputControl, view)
    }
    
    /// Provide static cell for form.
    ///
    /// - Parameters:
    ///   - formType: `LoginFormType` type.
    ///   - formView: View to add as cell subView.
    /// - Returns: `UITableViewCell` instance.
    static func provideCellForFormType(_ formType: LoginFormType, formView: UIView) -> UITableViewCell {
        
        let cell = UITableViewCell()
        cell.selectionStyle = .none
        cell.backgroundColor = .clear
        cell.contentView.addSubview(formView)
        formView.constraintToSuperviewEdges(leading: 16, trainling: 16, bottom: 0, top: 0)
        
        return cell
    }
}
