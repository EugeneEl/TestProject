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
    
    private let dataWorker: FeedItemDataWorkerProtocol
    private let apiWorker: FeedAPIProtocol
    
    // MARK: Initialization
    
    init(dataWorker: FeedItemDataWorkerProtocol, apiWorker: FeedAPIProtocol) {
        self.dataWorker = dataWorker
        self.apiWorker = apiWorker
    }
    
    // MARK: - Public
    
    func fetchItemsUsingLocalData(_ isUsingLocalData: Bool, success: @escaping FeedFetchCompletionSuccess, failure: @escaping FeedFetchCompletionFail) {
        apiWorker.fetchNewsWithCompletionSuccess({[weak self] (items) in
            guard let strongSelf = self else {return}
            // update local storage
            if isUsingLocalData {
                strongSelf.dataWorker.updateFeedItems(items, completion: { (error) in

                })
            }
            success(items)
        }) {[weak self] (error) in
            guard let strongSelf = self else {return}
            // attempt to fetch last saved
            if isUsingLocalData {
                strongSelf.dataWorker.getFeedItems(completion: { (items) in
                    success(items)
                })
            } else {
                failure(error, [])
            }
        }
    }
    
    func clearData() {
        dataWorker.deleteFeedItems { (error) in
            print("deleted all items")
        }
    }
}
