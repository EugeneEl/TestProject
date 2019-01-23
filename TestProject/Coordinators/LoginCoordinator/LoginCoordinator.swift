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
    
    let loginBuilder: LoginSceneBuilder
    
    // MARK: - Initialization
    
    init(userSessionService: UserSessionService) {
        self.loginBuilder = LoginSceneBuilder(userSessionService: userSessionService,
                             model: LoginInputModel(email: "",
                                                    password: ""))
        super.init(flow: .login)
    }
    
    // MARK: - Public
    
    func buildLoginScreen() -> SignInVC {
        return loginBuilder.buildLoginScene()
    }
}

