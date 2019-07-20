//
//  ListMainView.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 7/20/19.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

final class ListMainView: UIView {
    
    // MARK: - Public Vars
    
    let tableView = UITableView()
    let refreshControl = UIRefreshControl()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupUI()
    }
    
    // MARK: - Required initializer
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private
    // MARK: - Helpers
    
    fileprivate func setupUI() {
        addSubview(tableView)
        tableView.constraintToSuperviewEdges()
        
        setupTableView()
        setupRefreshControl()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = Constants.Colors.grey
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableView.automaticDimension
        setupRefreshControl()
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 44, right: 0)
    }
    
    private func setupRefreshControl() {
        refreshControl.tintColor = .blue
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
    }
}
