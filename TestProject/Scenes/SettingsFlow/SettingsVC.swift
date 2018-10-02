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
    
    // MARK: - Vars
    
    var presenter: SettingsViewOutput?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tabBarItem = MenuTabBarItem.settings.tabBarItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        view.backgroundColor = Constants.Colors.grey
        configureNavigationBarUI()
    }
    
    // MARK: - Private
    // MARK: - Actions
    
    @IBAction fileprivate func logoutDidTap() {
        presenter?.handleLogoutTap()
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
                                              titleStyle: .text("Profile", navigationBarTitleUI))
        
        
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
