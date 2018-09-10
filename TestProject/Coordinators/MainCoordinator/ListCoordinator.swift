//
//  ListCoordinator.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

class ListCoordinator: Coordinator {
    
    // MARK: - Vars
    
    private let listBuilder: ListSceneBuilder
    
    // MARK: - Initialization
    
    init(userSession: UserSession) {
        self.listBuilder = ListSceneBuilder(feedDataProvider: userSession.workers.feedbackDataWorker)
        super.init(flow: .list)
    }
    
    func provideListScene() -> UIViewController {
        let navigationController = BaseNavigationController(rootViewController: listBuilder.buildListScene())
        return navigationController
    }
}
