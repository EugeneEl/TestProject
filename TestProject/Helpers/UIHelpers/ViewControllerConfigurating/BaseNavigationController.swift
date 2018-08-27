//
//  BaseNavigationController.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 08.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

class BaseNavigationController: UINavigationController {
    
    //  navigation controllers don’t normally ask their children for a preferred status bar style. It manages for its own. Also it is possible to ask top most vc for its status bar style but it might cause misunderstanding
    var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    // MARK: - StatusBarStyle
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.interactivePopGestureRecognizer?.isEnabled = false
    }
}
