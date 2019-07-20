//
//  AuthWorker.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 02.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

enum AuthFlow {
    case login(SignInModel)
}

typealias AuthCompletionSuccess = (_ withFlow: AuthFlow, _ user: User) -> ()
typealias AuthCompletionFailure = (_ withFlow: AuthFlow, _ errorText: String) -> ()

protocol AuthUserProtocol {
    func authUserWithFlow(_ flow: AuthFlow,
                          success: @escaping AuthCompletionSuccess,
                          failure: @escaping AuthCompletionFailure)
}

final class AuthWorker {
    
    // MARK: - Vars
    
    private let networkService: NetworkService = ServiceLocator.inject()
    
    // MARK: - Initialization
    
    // MARK: - Public
    
    func authUserWithFlow(_ flow: AuthFlow,
                          success: @escaping AuthCompletionSuccess,
                          failure: @escaping AuthCompletionFailure) {
        switch flow {
        case .login(let model):
            break
        }
        
        let json = JSON(localFileName: "User")
        if let user = User(json: json) {
            success(flow, user)
        } else {
            failure(flow, "Cannot fetch user")
        }
    }
}
