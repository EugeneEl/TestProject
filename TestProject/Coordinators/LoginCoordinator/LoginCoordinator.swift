//
//  LoginCoordinator.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

class LoginCoordinator: Coordinator {
    
    // MARK: - Vars
    
    let navigationController: BaseNavigationController
    
    let loginBuilder = LoginSceneBuilder(authWorker: AuthWorker(),
                                        model: LoginInputModel(email: "",
                                                                password: ""))
    
    // MARK: - Initialization
    
    init(navigationController: BaseNavigationController) {
        self.navigationController = navigationController
        super.init(flow: .login)
    }
    
    // MARK: - Public
    
    func buildLoginScreen() -> NewLoginVC {
        return loginBuilder.buildLoginSceneWithDelegate(delegate: self)
    }
}

// MARK: - LoginRouterDelegate

extension LoginCoordinator: LoginRouterDelegate {
    func userDidLoginWithSession(_ session: UserSessionService) {
        
    }
}
