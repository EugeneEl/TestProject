//
//  NetwordDebugger.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 23.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import Alamofire
import Dotzu

final class NetworkDebugger {
    
    // MARK: - Public
    
    class func setupDebugger() {
        switch AppConfigurationProvider.shared.configuration {
        case .debug, .test:
            Dotzu.sharedManager.disable()
        case .adhoc:
            Dotzu.sharedManager.disable()
        case .release:
            Dotzu.sharedManager.disable()
        }
    }
    
    class func setupNetworkDebugger(_ configuration: URLSessionConfiguration) {
        switch AppConfigurationProvider.shared.configuration {
        case .debug, .test:
            Dotzu.sharedManager.addLogger(session: configuration)
        case .adhoc:
            Dotzu.sharedManager.addLogger(session: configuration)
        case .release:
            break
        }
    }
}

func logAssertionFailuire(_ text: String) {
    print("__ASSERTION!!!: \(text)")
    assertionFailure(text)
}
