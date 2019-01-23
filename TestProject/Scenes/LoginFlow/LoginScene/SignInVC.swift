//
//  SignInVC.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 16.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

final class SignInVC: UIViewController {
    
    // MARK: - Vars
    
    fileprivate let mainView = SignInMainView()
    fileprivate let presenter = SignInPresenter()
    
    // MARK: - Initialization
    
    init(worker: Any) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupInputControllers()
    }
    
    // MARK: - Private
    // MARK: - Helpers
    
    fileprivate func setupUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    fileprivate func setupInputControllers() {
        let emailController = LoginFormModuleProvider.setupModuleForLoginFormType(.email, containerView: mainView.emailView)
        let passwordController = LoginFormModuleProvider.setupModuleForLoginFormType(.password, containerView: mainView.passwordView)
        
        presenter.addInputController(emailController)
        presenter.addInputController(passwordController)
    }
}
