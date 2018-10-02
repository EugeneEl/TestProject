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
 
    // MARK: - Outlets
    
    @IBOutlet fileprivate weak var tableView: UITableView!
    
    // MARK: - Vars
    
    fileprivate var refreshControl: UIRefreshControl?
    var presenter: ListViewOutput?
    var router: ListRouter?
    fileprivate var safariControllerHelper: SafariControllerHelper?
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tabBarItem = MenuTabBarItem.feed.tabBarItem
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        safariControllerHelper = SafariControllerHelper(viewController: self)
        view.backgroundColor = Constants.Colors.grey
        presenter?.fetchData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureNavigationBarUI()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    // MARK: - Private
    
    private func setupTableView() {
        tableView.backgroundColor = Constants.Colors.grey
        tableView.registerCellsWithIdentifiers([FeedListTableViewCell.cellIdentifier()])
        tableView.estimatedRowHeight = 85.0
        tableView.rowHeight = UITableViewAutomaticDimension
        setupRefreshControl()
        tableView.contentInset = UIEdgeInsetsMake(0, 0, 44, 0)
    }
    
    private func setupRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .blue
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.backgroundView = refreshControl
        }
    }
    
    // MARK: - Actions
    
    @objc fileprivate func refresh() {
        presenter?.fetchData()
    }
}

// MARK: - ListPresenterOutput

extension ListVC: ListViewInput {
    func listSceneStateDidChange(_ state: ListSceneState) {
        switch state {
        case .isLoading:
            HudHelper.showHUDInView(view, animated: true)
            refreshControl?.beginRefreshing()
        case .feedDidFetch(let items, let errorText):
            HudHelper.hideHUDInView(view, animated: false)
            refreshControl?.endRefreshing()
            if !items.isEmpty {
                tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension ListVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.feedItems.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FeedListTableViewCell.dequeueFromTableView(tableView)
        
        guard let item = presenter?.feedItems[safe: indexPath.row] else {
            return cell
        }
        
        cell.delegate = self
        cell.configureWithObject(item)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension ListVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let item = presenter?.feedItems[safe: indexPath.row] else {return}
        let worker = FeedDataWorker()
        let entity = worker.fetchItemByID(item.url.absoluteString) { (itemInStore) in
            print("itemInStore: \(itemInStore)")
        }
        print("next step")
    }
}

// MARK: - FeedListTableViewCellInteractable

extension ListVC: FeedListTableViewCellInteractable {
    func linkDidTapInCell(_ cell: FeedListTableViewCell) {
//        guard let indexPath = tableView.indexPath(for: cell),
//            let url = presenter?.provideURLForIndex(indexPath.row) else {return}
//        safariControllerHelper?.openURLInSafariViewController(url)
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
