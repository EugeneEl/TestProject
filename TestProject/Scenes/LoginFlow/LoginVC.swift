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
    
    fileprivate let tap = UITapGestureRecognizer()
    fileprivate var presenter = LoginPresenter()
    fileprivate var router: LoginRouter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTap()
        configureScene()
        presenter.triggerInitialState()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    // MARK: - Private
    
    private func configureScene() {
        presenter.output = self
        router = LoginRouter(viewController: self)
    }
    
    private func setupTap() {
        tap.addTarget(self, action:#selector(LoginVC.didTapOnView))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Actions
    
    @IBAction fileprivate func didTapOnView() {
        view.endEditing(true)
    }
    
    @IBAction fileprivate func didTapSignIn(_ sender: UIButton) {
        presenter.loginDidTap()
    }
}

// MARK: - UITextFieldDelegate

extension LoginVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        guard let text = textField.text else {
            return true
        }
        
        var txtAfterUpdate: NSString = text as NSString
        txtAfterUpdate = txtAfterUpdate.replacingCharacters(in: range, with: string) as NSString
        
        // usually for static forms I prefer to use some more flexible solutions.
        // this implementation in UIViewController is for simplicity in demo projects.
        if textField == emailTextField {
            presenter.updateEmail(txtAfterUpdate as String)
        } else if textField == passwordTextField {
            presenter.updatePassword(txtAfterUpdate as String)
        }
        
        return true
    }
}

// MARK: - ViewControllerUIConfigurating

extension LoginVC: ViewControllerUIConfigurating {
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

// MARK: - LoginPresenterOutput

extension LoginVC: LoginPresenterOutput {
    func loginStateDidChange(_ state: LoginSceneState) {
        switch state {
        case .isLogging:
            loginButton.isEnabled = false
            HudHelper.showHUDInView(view, animated: true)
        case .loginInput(let model):
            HudHelper.hideHUDInView(view, animated: false)
            loginButton.isEnabled = model.isModelValid()
        case .loginFail(let error):
            loginButton.isEnabled = true
            HudHelper.hideHUDInView(view, animated: false)
        case .loginSuccess:
            HudHelper.hideHUDInView(view, animated: false)
            loginButton.isEnabled = false
            router?.navigateToMainScene()
        }
    }
}
