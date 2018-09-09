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
    
    private let listBuilder = ListSceneBuilder(feedDataProvider: FeedDataProvider(dataWorker: FeedDataWorker(),
                                                                          apiWorker: FeedAPIWorker()))
    
    // MARK: - Initialization
    
    init() {
        super.init(flow: .list)
    }
    
    func provideListScene() -> UIViewController {
        let navigationController = BaseNavigationController(rootViewController: listBuilder.buildListScene())
        return navigationController
    }
}
