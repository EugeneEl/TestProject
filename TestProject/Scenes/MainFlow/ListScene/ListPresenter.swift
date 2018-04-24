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
    case feedDidFetch([FeedItemJSONModel], String?)
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
    private let feedAPIWorker = FeedAPIWorker()
    private (set) internal var feedItems = [FeedItemJSONModel]()
    
    // MARK: - Public
    
    func fetchData() {
        state = .isLoading
        
        feedAPIWorker.fetchNewsWithCompletionSuccess({[weak self] (items) in
            guard let strongSelf = self else {return}
            strongSelf.feedItems = items
            strongSelf.state = .feedDidFetch(strongSelf.feedItems, nil)
        }) {[weak self] (errorText) in
            guard let strongSelf = self else {return}
            strongSelf.state = .feedDidFetch(strongSelf.feedItems, errorText)
        }
    }
    
    func provideURLForIndex(_ index: Int) -> URL? {
        let item = feedItems[safe: index]
        return item?.url
    }
}
