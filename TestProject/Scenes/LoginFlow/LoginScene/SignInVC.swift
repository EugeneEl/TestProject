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
    
    // MARK: - Private Vars
    
    fileprivate let mainView = SignInMainView()
    fileprivate let presenter: SignInPresenter
    
    // MARK: - Initialization
    
    init(worker: UserSessionService) {
        self.presenter = SignInPresenter(userSessionService: worker)
        super.init(nibName: nil, bundle: nil)
        presenter.view = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupBindings()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBarUI()
    }
    
    // MARK: - Private
    // MARK: - Helpers
    
    fileprivate func setupUI() {
        view.addSubview(mainView)
        mainView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
    
    fileprivate func setupBindings() {
        mainView.signInButton.addTarget(self, action: #selector(signInDidTap), for: .touchUpInside)
        setupInputControllers()
    }
    
    fileprivate func setupInputControllers() {
        let emailController = LoginFormModuleProvider.setupModuleForLoginFormType(.email,
                                                                                  containerView: mainView.emailView)
        let passwordController = LoginFormModuleProvider.setupModuleForLoginFormType(.password,
                                                                                     containerView: mainView.passwordView)
        
        presenter.addInputController(emailController)
        presenter.addInputController(passwordController)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func signInDidTap() {
        presenter.loginDidTap()
    }
}

// MARK: - SignInViewInput

extension SignInVC: SignInViewInput {
    func loginStateDidChange(_ state: SignInSceneState) {
        switch state {
        case .initial:
            break
        case .loginRequest(let request):
            switch request {
            case .isLoading:
                HudHelper.showHUDInView(view, animated: true)
            case .failure(_, let errorText, _):
                HudHelper.hideHUDInView(view, animated: false)
                DialogHelper.showOkAlert(errorText, viewController: self)
            case .success:
                HudHelper.hideHUDInView(view, animated: false)
            }
        }
    }
}

// MARK: - ViewControllerUIConfigurating

extension SignInVC: ViewControllerUIConfigurating {
    var navigationBarAppearance: NavigationBarAppearance? {
        return nil
    }
    
    var isNavigationBarHidden: Bool {
        return true
        
    }
    
    var isBackButtonVisible: Bool {
        return false
    }
}
