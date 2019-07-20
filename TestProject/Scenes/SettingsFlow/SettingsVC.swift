//
//  SettingsVC.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 25.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

protocol SettingsViewOutput: class {
    func handleLogoutTap()
    var  view: SettingsViewInput? {get set}
}

final class SettingsVC: UIViewController {
    
    // MARK: - Private Vars
    
    fileprivate let mainView = SettingsMainView()
    fileprivate let presenter: SettingsViewOutput
    
    // MARK: - Initialization
    
    init(presenter: SettingsViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        
        tabBarItem = MenuTabBarItem.settings.tabBarItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBindings()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBarUI()
    }
    
    // MARK: - Private
    // MARK: - Helpers
    
    fileprivate func setupView() {
        view.backgroundColor = Constants.Colors.grey
        
        view.addSubview(mainView)
        mainView.constraintToSuperviewEdges()
    }
    
    fileprivate func setupBindings() {
        mainView.logoutButton.addTarget(self, action: #selector(logoutDidTap), for: .touchUpInside)
    }
    
    // MARK: - Actions
    
    @IBAction fileprivate func logoutDidTap() {
        presenter.handleLogoutTap()
    }
}

// MARK: - SettingsPresenterOutput

extension SettingsVC: SettingsViewInput {
    func stateDidChange(_ state: SettingsSceneState) {
        switch state {
        case .initial:
            break
        case .isLogouting:
            HudHelper.showHUDInView(view, animated: true)
        case .logouted:
            HudHelper.hideHUDInView(view, animated: false)
        }
    }
}

// MARK: - ViewControllerUIConfigurating

extension SettingsVC: ViewControllerUIConfigurating {
    var navigationBarAppearance: NavigationBarAppearance? {
        let navigationBarTitleUI = NavigationBarTitleUI(color: .white, font: UIFont.systemFont(ofSize: 15))
        let navigationBarUI = NavigationBarUI(isSeparatorVisible: false,
                                              translucent: false,
                                              navigationBarColor: Constants.Colors.background,
                                              navigationBarTintColor: .black,
                                              titleStyle: .text("settings_navitation_title".localized, navigationBarTitleUI))
        
        
        return NavigationBarAppearance(navigationBarUI: navigationBarUI,
                                       leftItem: nil,
                                       rightItem: nil)
    }
    
    var isNavigationBarHidden: Bool {
        return false
        
    }
    
    var isBackButtonVisible: Bool {
        return false
    }
}
