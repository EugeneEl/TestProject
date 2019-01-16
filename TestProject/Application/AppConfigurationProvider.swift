//
//  AppConfigurationProvider.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 16.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation

enum AppConfiguration {
    case test
    case debug
    case adhoc
    case release
}

final class AppConfigurationProvider {
    
    // MARK: - Vars
    
    static let shared = AppConfigurationProvider()
    
    let configuration: AppConfiguration
    
    // MARK: - Initialization
    
    private init() {
        #if DEBUG
        self.configuration = .debug
        print("config: debug")
        #elseif ADHOC
        self.configuration = .adhoc
        print("config: adhoc")
        #elseif TEST
        self.configuration = .test
        print("config: test")
        #else
        self.configuration = .release
        print("config: release")
        #endif
    }
}
