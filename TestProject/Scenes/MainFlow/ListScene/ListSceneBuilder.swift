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
    
    let feedDataProvider: FeedDataProvider
    
    // MARK: - Public
    
    func buildListScene() -> ListVC {
        let vc = ListVC.instantiateFromStoryboardId(.main)
        let presenter = ListPresenter(dataProvider: feedDataProvider)
        let router = ListRouter(viewController: vc)
        vc.router = router
        vc.presenter = presenter
        presenter.listViewInput = vc
        
        return vc
    }
}
