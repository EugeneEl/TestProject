//
//  ListVC.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 12.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import UIKit

protocol ListViewOutput: class {
    func provideURLForIndex(_ index: Int) -> URL?
    func fetchData()
    var feedItems: [FeedItem] {get}
    var view: ListViewInput? {get set}
}

class ListVC: UIViewController {
 
    // MARK: - Public Vars
    
    var router: ListRouter?
    
    // MARK: - Private Vars

    fileprivate let mainView = ListMainView()
    fileprivate var presenter: ListViewOutput
    fileprivate var safariControllerHelper: SafariControllerHelper?
    
    // MARK: - Initialization
    
    init(listPresenter: ListViewOutput) {
        presenter = listPresenter
        super.init(nibName: nil, bundle: nil)
        safariControllerHelper = SafariControllerHelper(viewController: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("not implemented")
    }
    
    // MARK: - Lifecycle
    
    override func loadView() {
         super.loadView()
        
        tabBarItem = MenuTabBarItem.feed.tabBarItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMainView()
        setupBindings()
        presenter.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBarUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private
    // MARK: - Helpers
    
    fileprivate func setupMainView() {
        view.addSubview(mainView)
        mainView.constraintToSuperviewEdges()
        
        view.backgroundColor = Constants.Colors.grey
    }
    
    fileprivate func setupBindings() {
        mainView.tableView.registerCellsWithIdentifiers([FeedListTableViewCell.cellIdentifier()])
        mainView.tableView.dataSource = self
        mainView.tableView.delegate = self
        mainView.refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    // MARK: - Actions
    
    @objc fileprivate func refresh() {
        presenter.fetchData()
    }
}

// MARK: - ListPresenterOutput

extension ListVC: ListViewInput {
    func listSceneStateDidChange(_ state: ListSceneState) {
        switch state {
        case .isLoading:
            HudHelper.showHUDInView(view, animated: true)
            mainView.refreshControl.beginRefreshing()
        case .feedDidFetch(let items, let errorText):
            HudHelper.hideHUDInView(view, animated: false)
            mainView.refreshControl.endRefreshing()
            if !items.isEmpty {
                mainView.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.feedItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FeedListTableViewCell.dequeueFromTableView(tableView)
        
        guard let item = presenter.feedItems[safe: indexPath.row] else {
            return cell
        }
        
        cell.delegate = self
        cell.configureWithObject(item)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat  {  return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = presenter.feedItems[safe: indexPath.row] else {return}
    }
}

// MARK: - FeedListTableViewCellInteractable

extension ListVC: FeedListTableViewCellInteractable {
    func linkDidTapInCell(_ cell: FeedListTableViewCell) {
        guard let indexPath = mainView.tableView.indexPath(for: cell),
            let url = presenter.provideURLForIndex(indexPath.row) else {return}
        safariControllerHelper?.openURLInSafariViewController(url)
    }
}

// MARK: - ViewControllerUIConfigurating

extension ListVC: ViewControllerUIConfigurating {
    var navigationBarAppearance: NavigationBarAppearance? {
        let navigationBarTitleUI = NavigationBarTitleUI(color: .white, font: UIFont.systemFont(ofSize: 15))
        let navigationBarUI = NavigationBarUI(isSeparatorVisible: false,
                                              translucent: false,
                                              navigationBarColor: Constants.Colors.background,
                                              navigationBarTintColor: .white,
                                              titleStyle: .text("News", navigationBarTitleUI))
        
        
        return NavigationBarAppearance(navigationBarUI: navigationBarUI,
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
