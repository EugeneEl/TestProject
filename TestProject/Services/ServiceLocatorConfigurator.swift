//
//  ServiceLocatorConfigurator.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 18.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class ServiceLocatorConfigurator {
    
    // MARK: - Public
    
    static func setupServices() {
        ServiceLocator.sharedLocator.registerSingleton(AlamofireNetworkClient.shared as NetworkService)
    }
}
