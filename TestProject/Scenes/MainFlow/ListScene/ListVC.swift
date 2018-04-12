//
//  ListVC.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 12.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

class ListVC: UIViewController {
 
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: - Vars
    
    fileprivate let presenter = ListPresenter()
    fileprivate var router: ListRouter?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScene()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI()
    }
    
    // MARK: - Private
    
    private func setupScene() {
        router = ListRouter(viewController: self)
    }
}

// MARK: - ViewControllerUIConfigurating

extension ListVC: ViewControllerUIConfigurating {
    var navigationBarAppearance: NavigationBarAppearance? {
        return NavigationBarAppearance(isSeparatorVisible: false,
                                       translucent: false,
                                       navigationBarColor: .white,
                                       navigationBarTintColor: .black,
                                       navigationTitle: "News",
                                       navigationTitleColor: .black,
                                       leftItem: nil,
                                       rightItem: nil)
    }
    
    var isNavigationBarHidden: Bool {
        return false
        
    }
    
    var isBackButtonVisible: Bool {
        return false
    }
}
