//
//  Coordinator.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

enum CoordinatorFlow {
    case root
    case login
    case tabBar
    case list
    case settings
}

class Coordinator: NSObject {
    
    // MARK: - Vars
    
    let flow: CoordinatorFlow
    
    // MARK: - Initialization
    
    init(flow: CoordinatorFlow) {
        self.flow = flow
        super.init()
    }
}
