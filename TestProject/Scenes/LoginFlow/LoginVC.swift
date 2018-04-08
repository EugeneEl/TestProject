//
//  LoginVC.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 08.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

class LoginVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var welcomeTitleLabel: UILabel!
    @IBOutlet fileprivate weak var emailTitleLabel: UILabel!
    @IBOutlet fileprivate weak var passwordTitleLabel: UILabel!
    @IBOutlet fileprivate weak var emailTextField: UITextField!
    @IBOutlet fileprivate weak var passwordTextField: UITextField!
    @IBOutlet fileprivate weak var loginButton: UIButton!
    
    // MARK: - Vars
    
    fileprivate var presenter = LoginPresenter()
    fileprivate var router: LoginRouter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureScene()
    }
    
    // MARK: - Private
    
    private func configureScene() {
        router = LoginRouter(viewController: self)
    }
}
