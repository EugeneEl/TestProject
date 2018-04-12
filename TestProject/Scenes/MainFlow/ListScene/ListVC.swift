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
    
    // MARK: - Private
    
    private func setupScene() {
        router = ListRouter(viewController: self)
    }
    
}
