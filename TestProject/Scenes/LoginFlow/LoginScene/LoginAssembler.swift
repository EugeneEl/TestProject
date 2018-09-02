//
//  LoginAssembler.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 28.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class LoginAssembler {
    
    static func assembleLoginSceneWithUserSessionManager(_ session: UserSessionService, loginRouterDelegate: LoginRouterDelegate) {
        presenter.output = self
        router = LoginRouter(viewController: self)
    }
}
