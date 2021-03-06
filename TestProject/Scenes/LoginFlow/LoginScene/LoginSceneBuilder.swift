//
//  LoginAssembler.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 28.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

struct LoginSceneBuilder {
    
    let userSessionService: UserSessionService
    
    func buildLoginScene() -> SignInVC {
        let vc = SignInVC(worker: userSessionService)

        return vc
    }
}
