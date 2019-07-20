//
//  UIViewController+Extensions.swift
//  EGS
//
//  Created by Eugene Goloboyar on 20.03.2018.

import Foundation
import UIKit

extension UIViewController {
    
    func enforceLoadView() {
        // warning! hack to force load view
        let _ = view
    }
    
    func popToSpecificViewControllerClass(_ controllerClass: AnyClass) {
        guard let viewControllers = navigationController?.viewControllers else { return }
        for aViewController in viewControllers {
            if aViewController.classForCoder == controllerClass {
                self.navigationController!.popToViewController(aViewController, animated: true)
                return
            }
        }
    }
}




