//
//  MainCoordinator.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

class MainCoordinator: Coordinator {
    
    // MARK: - Vars
    
    private let listBuilder = ListSceneBuilder(feedDataProvider: FeedDataProvider(dataWorker: FeedDataWorker(),
                                                                                  apiWorker: FeedAPIWorker()))
    let menuTabBarVC: MenuTabBarVC
//
//    let loginAssembler = LoginAssembler(authWorker: AuthWorker(),
//                                        model: LoginInputModel(email: "",
//                                                               password: ""))
    
    // MARK: - Initialization
    
    init(menuTabBarVC: MenuTabBarVC) {
        self.menuTabBarVC = menuTabBarVC
        super.init(flow: .tabBar)
    }
    
    // MARK: - Public
    
    private func setupNavigationWithLaunchOptions(_ options: [UIApplicationLaunchOptionsKey: Any]?) {
        let mainNavigationVC = BaseNavigationController(rootViewController: listBuilder.buildListScene())
        
        let settingsNavigationVC = BaseNavigationController(rootViewController: SettingsVC.instantiateFromStoryboardId(.settings))
        viewControllers = [mainNavigationVC, settingsNavigationVC]
    }
    
//    func buildListScreen() -> ListVC {
//
//    }
//
//    func buildSettingsScreen() -> SettingsVC {
//
//    }
    
//    func buildListScreen() -> NewLoginVC {
//        //return loginAssembler.assembleLoginSceneWithDelegate(delegate: self)
//    }
}


