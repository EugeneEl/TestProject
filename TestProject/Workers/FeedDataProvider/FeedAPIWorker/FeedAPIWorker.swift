//
//  FeedAPIWorker.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 18.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

typealias FetchFeedListCompletionSuccess = (_ rssItems: [FeedItem]) -> ()
typealias FetchFeedListCompletionFail = (_ errorText: String) -> ()

protocol FeedAPIProtocol {
    func fetchNewsWithCompletionSuccess(_ success: @escaping FetchFeedListCompletionSuccess, failure: @escaping FetchFeedListCompletionFail)
}

final class FeedAPIWorker: FeedAPIProtocol {
    
    // MARK: - Vars
    
    fileprivate let networkService: NetworkService = ServiceLocator.inject()
    
    // MARK: - Public
    
    func fetchNewsWithCompletionSuccess(_ success: @escaping FetchFeedListCompletionSuccess, failure: @escaping FetchFeedListCompletionFail) {
        let path = "/stock/aapl/news/last/5"
        
        networkService.GET(path, parameters: nil, headers: nil, encoding: .urlEncoded, withAuthorization: true) { (result) in
            switch result {
            case .success(let rawData):
                guard let data = rawData else {
                    success([])
                    return
                }
                
                let json = JSON(data: data, error: nil)

                var models = [FeedItem]()
                for (_,subJson):(String, JSON) in json {
                    if let feed = FeedItem(json: subJson) {
                        models.append(feed)
                    }
                }
                
                success(models)
            case .failure(let errorJSON, let errorString, let statusCode):
                print(errorString)
                failure(errorString ?? ErrorConstants.baseError)
            }
        }
    }
}


