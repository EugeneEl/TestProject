 //
 //  NewLoginVC.swift
 //  TestProject
 //
 //  Created by Eugene Goloboyar on 19.08.2018.
 //  Copyright © 2018 Eugene Goloboyar. All rights reserved.
 //
 
 import Foundation
 import UIKit
 
 protocol LoginViewOutput: class {
    func provideTextForForm(_ formType: LoginFormType) -> String
    func loginDidTap()
    var inputControllers: [FormInputConroller]  {get set}
    var formTypes: [LoginFormType] {get}
    var loginViewInput: LoginViewInput? {get set}
 }
 
 final class NewLoginVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: - Constants
    
    fileprivate static let headerHeight: CGFloat = 150
    fileprivate static let footerHeight: CGFloat = 66
    
    // MARK: - Vars
    
    var presenter: LoginViewOutput?
    var router: LoginRouter?
    fileprivate var cellsDictionary = [IndexPath : UITableViewCell]()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBarUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private
    // MARK: - Helpers
    
    private func setupUI() {
        view.backgroundColor = Constants.Colors.background
    }
 }
 
 // MARK: - UITableViewDataSource
 
 extension NewLoginVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = cellsDictionary[indexPath] {
            return cell
        }
        
        let row = indexPath.row
        
        guard let dataPresenter = presenter, let loginFormType = presenter?.formTypes[safe: row] else {
            return UITableViewCell()
        }
        
        let text = dataPresenter.provideTextForForm(loginFormType)
        let formModule = LoginFormBuilder.provideInputControlModuleForFragment(loginFormType, initalText: text)
        
        let inputControl = formModule.0
        let formView = formModule.1
        let cell = LoginFormBuilder.provideCellForFormType(loginFormType, formView: formView)
        
        presenter?.inputControllers.append(inputControl)
        
        cellsDictionary[indexPath] = cell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.formTypes.count ?? 0
    }
 }
 
 // MARK: - UITableViewDelegate
 
 extension NewLoginVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return LoginFormType.inputHeight
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = LoginHeaderView.instantiateView()
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return NewLoginVC.headerHeight
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return NewLoginVC.footerHeight
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = LoginFooterView.instantiateView()
        footerView.delegate = self
        return footerView
    }
 }
 
 // MARK: - LoginFooterViewInteracting
 
 extension NewLoginVC: LoginFooterViewInteracting {
    func loginDidTap() {
        presenter?.loginDidTap()
    }
 }
 
 // MARK: - LoginPresenterOutput
 
 extension NewLoginVC: LoginViewInput {
    func loginStateDidChange(_ state: LoginSceneState) {
        switch state {
        case .isLogging:
            HudHelper.showHUDInView(view, animated: true)
        case .loginInput(let model):
            HudHelper.hideHUDInView(view, animated: false)
        case .loginFail(let error):
            HudHelper.hideHUDInView(view, animated: false)
        case .loginSuccess:
            HudHelper.hideHUDInView(view, animated: false)
        }
    }
 }
 
 // MARK: - ViewControllerUIConfigurating
 
 extension NewLoginVC: ViewControllerUIConfigurating {
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
