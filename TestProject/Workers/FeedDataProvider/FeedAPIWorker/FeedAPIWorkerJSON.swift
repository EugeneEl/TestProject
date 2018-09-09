//
//  FeedAPIWorkerJSON.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class FeedAPIWorkerJSON: FeedAPIProtocol {
    
    // MARK: - FeedAPIProtocol
    
    func fetchNewsWithCompletionSuccess(_ success: @escaping FetchFeedListCompletionSuccess, failure: @escaping FetchFeedListCompletionFail) {
        
        let json = JSON(localFileName: "Feed")
        
        var models = [FeedItem]()
        for (_,subJson):(String, JSON) in json {
            if let feed = FeedItem(json: subJson) {
                models.append(feed)
            }
        }
        
        success(models)
    }
}
