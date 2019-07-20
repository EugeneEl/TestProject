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

protocol ListViewInput: class {
    func listSceneStateDidChange(_ state: ListSceneState)
}

final class ListPresenter: ListViewOutput {
   
    // MARK: - Vars
    
    weak var view: ListViewInput?
    
    private var state: ListSceneState = .feedDidFetch([], nil) {
        didSet {
            view?.listSceneStateDidChange(state)
        }
    }
    
    private let apiWorker: FeedAPIProtocol
    private (set) internal var feedItems = [FeedItem]()
    
    // MARK: - Initialization
    
    init(apiWorker: FeedAPIProtocol) {
        self.apiWorker = apiWorker
    }
    
    // MARK: - Public
    
    func fetchData() { 
        state = .isLoading
        
        apiWorker.fetchNewsWithCompletionSuccess({[weak self] (items) in
            guard let strongSelf = self else {return}
            strongSelf.feedItems = items
            strongSelf.state = .feedDidFetch(items, nil)
        }) {[weak self] (errorText) in
            guard let strongSelf = self else {return}
            strongSelf.state = .feedDidFetch([], errorText)
        }
    }
    
    func provideURLForIndex(_ index: Int) -> URL? {
        let item = feedItems[safe: index]
        return item?.url
    }
}
