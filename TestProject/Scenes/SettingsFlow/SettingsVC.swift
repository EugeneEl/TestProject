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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
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
                                       navigationBarColor: .white,
                                       navigationBarTintColor: .black,
                                       navigationTitle: "Profile",
                                       navigationTitleColor: .black,
                                       leftItem: UIBarButtonItem(),
                                       rightItem: nil)
    }
    
    var isNavigationBarHidden: Bool {
        return false
        
    }
    
    var isBackButtonVisible: Bool {
        return false
    }
}
