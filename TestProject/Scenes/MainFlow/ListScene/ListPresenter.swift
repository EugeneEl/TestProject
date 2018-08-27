//
//  ListPresenter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 12.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

enum ListSceneState {
    case isLoading
    case feedDidFetch([FeedItem], String?)
}

protocol ListPresenterOutput: class {
    func listSceneStateDidChange(_ state: ListSceneState)
}

final class ListPresenter {
   
    // MARK: - Vars
    
    weak var output: ListPresenterOutput?
    
    private var state: ListSceneState = .feedDidFetch([], nil) {
        didSet {
            output?.listSceneStateDidChange(state)
        }
    }
    
    private let dataProvider = FeedDataProvider(dataWorker: FeedDataWorker(), apiWorker: FeedAPIWorker())
    private (set) internal var feedItems = [FeedItem]()
    
    // MARK: - Public
    
    func fetchData() {
        state = .isLoading
        
        dataProvider.fetchItemsUsingLocalData(true, success: {[weak self] (items) in
            guard let strongSelf = self else {return}
            strongSelf.feedItems = items
            strongSelf.state = .feedDidFetch(items, nil)
        }) {[weak self] (error, cachedItems) in
            guard let strongSelf = self else {return}
            strongSelf.feedItems = cachedItems
            strongSelf.state = .feedDidFetch(cachedItems, error)
        }
    }
    
    func provideURLForIndex(_ index: Int) -> URL? {
        let item = feedItems[safe: index]
        return item?.url
    }
}
