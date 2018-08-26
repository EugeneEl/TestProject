//
//  FeedAPIWorker.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 18.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

typealias FetchFeedListCompletionSuccess = (_ rssItems: [FeedItemJSONModel]) -> ()
typealias FetchFeedListCompletionFail = (_ errorText: String) -> ()

final class FeedAPIWorker {
    
    // MARK: - Vars
    
    fileprivate let networkService: NetworkService = ServiceLocator.inject()
    
    // MARK: - Public
    
    func fetchNewsWithCompletionSuccess(_ success: @escaping FetchFeedListCompletionSuccess, failure: @escaping FetchFeedListCompletionFail) {
        let path = "/stock/aapl/news/last/1000"
        
        networkService.GET(path, parameters: nil, headers: nil, encoding: .urlEncoded, withAuthorization: true) { (result) in
            switch result {
            case .success(let rawData):
                guard let data = rawData else {
                    success([])
                    return
                }
                
                let json = JSON(data: data, error: nil)

                var models = [FeedItemJSONModel]()
                for (_,subJson):(String, JSON) in json {
                    if let feed = FeedItemJSONModel(json: subJson) {
                        models.append(feed)
                    }
                }
                
                success(models)
            case .failure(let errorJSON, let errorString):
                print(errorString)
                failure(errorString ?? ErrorConstants.baseError)
            }
        }
    }
}
