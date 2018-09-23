//
//  FeedDataProvider.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

typealias FeedFetchCompletionSuccess = (_ rssItems: [FeedItem]) -> ()
typealias FeedFetchCompletionFail = (_ errorText: String, _ cachedItems: [FeedItem]) -> ()

final class FeedDataProvider {
    
    // MARK: - Public
    
    private let dataWorker: FeedDataControllerProtocol
    private let apiWorker: FeedAPIProtocol
    
    private var request: Cancellable?
    
    // MARK: Initialization
    
    init(dataWorker: FeedDataControllerProtocol, apiWorker: FeedAPIProtocol) {
        self.dataWorker = dataWorker
        self.apiWorker = apiWorker
    }
    
    // MARK: - Public
    
    func fetchItemsUsingLocalData(_ isUsingLocalData: Bool, success: @escaping FeedFetchCompletionSuccess, failure: @escaping FeedFetchCompletionFail) {
        request?.cancelRequest()
        request = apiWorker.fetchNewsWithCompletionSuccess({[weak self] (items) in
            guard let strongSelf = self else {return}
            // update local storage
            if isUsingLocalData {
                strongSelf.dataWorker.updateItems(items: items)
            }
            success(items)
        }) {[weak self] (error) in
            guard let strongSelf = self else {return}
            // attempt to fetch last saved
            if isUsingLocalData {
                strongSelf.dataWorker.fetchItems(completion: { (items) in
                    success(items)
                })
            } else {
                failure(error, [])
            }
        }
    }
    
    func clearData() {
        request?.cancelRequest()
        dataWorker.deleteItems {
            print("deleted")
        }
    }
}
