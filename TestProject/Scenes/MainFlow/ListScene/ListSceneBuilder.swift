//
//  ListSceneBuilder.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

struct ListSceneBuilder {
    
    // MARK: - Vars
    
    // MARK: - Public
    
    func buildListScene() -> ListVC {
        let apiWorker = ListWorkersFactory.buildFeedAPIWorker()
        let presenter = ListPresenter(apiWorker: apiWorker)
        let vc = ListVC(listPresenter: presenter)
        let router = ListRouter(viewController: vc)
        vc.router = router
        presenter.view = vc
        
        return vc
    }
}
