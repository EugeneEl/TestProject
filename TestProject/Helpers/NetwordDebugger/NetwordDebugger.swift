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
        Dotzu.sharedManager.enable()
    }
    
    class func setupNetworkDebugger(_ configuration: URLSessionConfiguration) {
        Dotzu.sharedManager.addLogger(session: configuration)
    }
}
