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
    private (set) internal var childCoordinators: Set<Coordinator> = []
    private var navigationController: BaseNavigationController?
    
    // MARK: - Initialization
    
    init(window: UIWindow, userSessionStorage: UserSessionStorage) {
        self.window = window
        self.userSessionService = UserSessionService(userSessionStorage: userSessionStorage)
        super.init(flow: .root)
        self.userSessionService.addListener(self)
    }
    
    // MARK: - Public
    
    func startWithLaunchOptions(_ options: [UIApplication.LaunchOptionsKey: Any]?) {
        navigationController = BaseNavigationController()
        let loginVC = buildLoginFlow()
        
        window.rootViewController = navigationController
        if userSessionService.isUserSessionRestored() {
            let mainMenuVC = buildMainFlowWithOptions(options)
            
            navigationController?.viewControllers = [loginVC, mainMenuVC]
        } else {
            navigationController?.viewControllers = [loginVC]
        }
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    // MARK: - Private
    
    private func buildMainFlowWithOptions(_ options: [UIApplication.LaunchOptionsKey: Any]?) -> UIViewController {
        let mainCoordinator = MainCoordinator(userSessionService: userSessionService)
        addCoordinator(mainCoordinator)
        let mainMenuVC = mainCoordinator.buildMainMenuWithLaunchOptions(options)
        
        return mainMenuVC
    }
    
    private func buildLoginFlow() -> UIViewController {
        let loginCoordinator = LoginCoordinator(userSessionService: userSessionService)
        addCoordinator(loginCoordinator)
        let loginVC = loginCoordinator.buildLoginScreen()
        loginVC.enforceLoadView()
        
        return loginVC
    }
    
    fileprivate func addCoordinator(_ coordinator: Coordinator) {
        childCoordinators.insert(coordinator)
    }
    
    fileprivate func removeCoordinatorWithFlow(_ flow: CoordinatorFlow) {
       childCoordinators = childCoordinators.filter { $0.flow != flow }
    }
}

// MARK: - UserSessionServiceDelegate

extension ApplicationCoordinator: UserSessionServiceDelegate {
    func userSessionStateDidChange(_ userSessionState: UserSessionState) {
        childCoordinators.removeAll()
        switch userSessionState {
        case .opened(let session):
            startWithLaunchOptions(nil)
        case .closed(let session):
            removeCoordinatorWithFlow(.tabBar)
            navigationController?.viewControllers.removeAll()
            startWithLaunchOptions(nil)
        }
    }
}
