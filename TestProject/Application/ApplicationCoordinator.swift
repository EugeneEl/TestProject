//
//  ApplicationCoordinator.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 02.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

final class ApplicationCoordinator: Coordinator {
    
    // MARK: - Vars
    
    private var window: UIWindow
    private let userSessionService: UserSessionService
    private (set) internal var childCoordinators: [Coordinator] = []
    private var navigationController: BaseNavigationController?
    
    // MARK: - Initialization
    
    init(window: UIWindow, userSessionStorage: UserSessionStorage) {
        self.window = window
        self.userSessionService = UserSessionService(userSessionStorage: userSessionStorage)
        super.init(flow: .root)
    }
    
    // MARK: - Public
    
    func startWithLaunchOptions(_ options: [UIApplicationLaunchOptionsKey: Any]?) {
        self.navigationController = BaseNavigationController()
        window.rootViewController = navigationController
        if userSessionService.isUserSessionRestored() {
            // start main
            let mainCoordinator = MainCoordinator(menuTabBarVC: MenuTabBarVC.instantiateFromStoryboardId(.main))
            
        } else {
            // start login
        }
    }
}
