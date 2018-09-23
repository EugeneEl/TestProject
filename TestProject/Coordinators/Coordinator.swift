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
    
    var flowIndex: Int {
        switch self {
        case .root:
            return 0
        case .login:
            return 1
        case .tabBar:
            return 2
        case .list:
            return 3
        case .settings:
            return 4
        }
    }
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

extension Coordinator {
    static func == (lhs: Coordinator, rhs: Coordinator) -> Bool {
        return lhs.flow == rhs.flow
    }
    
    override var hash: Int {
        return flow.flowIndex
    }
}
