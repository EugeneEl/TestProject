//
//  SettingsVC.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 25.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

final class SettingsVC: UIViewController {
    
    // MARK: - Vars
    
    private let presenter = SettingsPresenter()
    
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
        presenter.handleLogoutTap()
    }
}

// MARK: - ViewControllerUIConfigurating

extension SettingsVC: ViewControllerUIConfigurating {
    var navigationBarAppearance: NavigationBarAppearance? {
        return NavigationBarAppearance(isSeparatorVisible: false,
                                       translucent: false,
                                       navigationBarColor: Constants.Colors.background,
                                       navigationBarTintColor: .black,
                                       navigationTitle: "Profile",
                                       navigationTitleColor: .white,
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
