//
//  DialogHelper.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 7/20/19.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit
enum CustomPreferedAction {
    case approve, cancel
}

struct ActionData {
    let title: String
    let style: UIAlertAction.Style = .default
    let action: (UIAlertAction)->()
}

class DialogHelper {
    
    static func showErrorAlert(_ error: String?, viewController: UIViewController) {
        showAlert(message: error, buttonTitles: ["Close"], actions: [nil], delegate: viewController)
    }
    
    static func showOkAlert(_ message: String?, title: String? = nil, okTitle: String? = nil, viewController: UIViewController) {
        showAlert(title, message: message, buttonTitles: [okTitle ?? "Ok"], actions: [nil], delegate: viewController)
    }
    
    static func underDevelopment() {
        showOkAlertOnPVC("Under Development")
    }
    
    static func showAlertOnPVCWithActionAndCancel(_ action: @escaping () -> (), title: String?, message: String?) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.popoverPresentationController?.sourceView = topController.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            alert.addAction(UIAlertAction(title: "button_ok".localized, style: .default, handler:{_ in
                action()
            }))
            
            let cancelAction = UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil)
            alert.addAction(cancelAction)
            
            
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showActionAlertWithOk(_ title: String?, message: String?, controller: UIViewController, action:@escaping () -> (), actionTitle: String, style: UIAlertAction.Style, view: UIView? = nil, isCancelRerquired: Bool = true){
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        
        if isCancelRerquired {
            alert.addAction(cancelAction)
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: style, handler:{_ in
            action()
        }))
        
        if view != nil {
            alert.popoverPresentationController?.sourceView = view
            alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
        } else {
            alert.popoverPresentationController?.sourceView = controller.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
        }
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showActionAlertWithCancel(_ title: String?, message: String?, controller: UIViewController, action:@escaping () -> (), actionTitle: String, style: UIAlertAction.Style, view: UIView? = nil, isCancelRerquired: Bool = true){
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        
        let cancelAction = UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil)
        
        if isCancelRerquired {
            alert.addAction(cancelAction)
        }
        alert.addAction(UIAlertAction(title: actionTitle, style: style, handler:{_ in
            action()
        }))
        
        if view != nil {
            alert.popoverPresentationController?.sourceView = view
            alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
        } else {
            alert.popoverPresentationController?.sourceView = controller.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
        }
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showAlertOnPVCWithAction(_ action: @escaping () -> (), title: String?, message: String?) {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            alert.popoverPresentationController?.sourceView = topController.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
            
            alert.addAction(UIAlertAction(title: "button_ok".localized, style: .default, handler:{_ in
                action()
            }))
            
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    static func showAlertOnControllerWithAction(controller: UIViewController, action: @escaping () -> (), title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.popoverPresentationController?.sourceView = controller.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
        
        alert.addAction(UIAlertAction(title: "button_ok".localized, style: .default, handler:{_ in
            action()
        }))
        
        controller.present(alert, animated: true, completion: nil)
    }
    
    static func showAlert(_ title: String? = nil, message: String?, buttonTitles:[String], actions: [(() -> ())?], delegate: UIViewController) {
        MultiActionAlert(style: UIAlertController.Style.alert, title: title, message: message, buttonTitles: buttonTitles, actions: actions, delegate: delegate).showAlert()
    }
    
    static func showSheet(_ title: String? = nil, message: String?, buttonTitles:[String], actions: [(() -> ())?], delegate: UIViewController) {
        MultiActionAlert(style: UIAlertController.Style.actionSheet, title: title, message: message, buttonTitles: buttonTitles, actions: actions, delegate: delegate).showAlert()
    }
    
    static func showOkAlertOnPVC(_ message:String, title: String? = nil, okTitle: String? = nil) {
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            showOkAlert(message, title: title, okTitle: okTitle, viewController: topController)
        }
    }
    
    static func showInputAlert(title:String? = nil, message:String? = nil, buttons:[String], actionStyles:[UIAlertAction.Style]? = nil, actions:[(() -> ())?], delegate: UIViewController, textfieldConfigurationHandler:@escaping ((UITextField) -> Void)){
        MultiActionAlert(style: .alert, title: title, message: message, buttonTitles: buttons, actionStyles: actionStyles, actions: actions, delegate: delegate, textfieldConfigurationHandler: textfieldConfigurationHandler).showAlert()
    }
    
    static func getTopRootViewController() -> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            return topController
        }
        
        return nil
    }
}

class MultiActionAlert {
    let style: UIAlertController.Style
    let title: String?
    let message: String?
    let buttonTitles:[String]
    let actions: [(() -> ())?]
    var delegate:UIViewController?
    let actionStyles:[UIAlertAction.Style]?
    let textfieldConfigurationHandler:((UITextField) -> Void)?
    
    init (style: UIAlertController.Style, title: String? = nil, message: String? = nil, buttonTitles:[String], actionStyles:[UIAlertAction.Style]? = nil, actions: [(() -> Void)?], delegate: UIViewController, textfieldConfigurationHandler:((UITextField) -> Void)? = nil) {
        self.style = style
        self.title = title
        self.message = message
        self.buttonTitles = buttonTitles
        self.actions = actions
        self.delegate = delegate
        self.actionStyles = actionStyles
        self.textfieldConfigurationHandler = textfieldConfigurationHandler
    }
    
    func showAlert() {
        if let delegate = self.delegate {
            let alert = UIAlertController(title: self.title, message: self.message, preferredStyle: self.style)
            alert.popoverPresentationController?.sourceView = delegate.view
            alert.popoverPresentationController?.sourceRect = CGRect(x: 0, y: 0, width: 30, height: 30)
            for x in 0..<buttonTitles.count {
                let buttonTitle = self.buttonTitles[x]
                let action =  self.actions[x]
                if let actionStyles = self.actionStyles{
                    let style = actionStyles[x]
                    alert.addAction(UIAlertAction(title: buttonTitle, style: style, handler: {_ in
                        action?()
                    }))
                } else {
                    alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: {_ in
                        action?()
                    }))
                }
            }
            if textfieldConfigurationHandler != nil{
                alert.addTextField(configurationHandler: self.textfieldConfigurationHandler)
            }
            //alert.view.tintColor = UIColor.red
            delegate.present(alert, animated: true, completion: nil)
        }
    }
}
