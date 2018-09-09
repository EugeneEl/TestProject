//
//  ListCoordinator.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

class ListCoordinator: Coordinator {
    
    // MARK: - Vars
    
    let navigationController: BaseNavigationController?
    
    private let listBuilder = ListSceneBuilder(feedDataProvider: FeedDataProvider(dataWorker: FeedDataWorker(),
                                                                          apiWorker: FeedAPIWorker()))
    
    // MARK: - Initialization
    
    init() {
        super.init(flow: .list)
    }
    
    func provideListScene() -> UIViewController {
        self.navigationController = BaseNavigationController(rootViewController: listBuilder.buildListScene())
        return self.navigationController
    }
}
