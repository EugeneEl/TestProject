//
//  FeedItem.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

struct FeedItem {
    var summary: String?
    var headline: String?
    var source: String?
    var url: URL
    var datetime: Date
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    
    private struct SerializationKeys {
        static let summary = "summary"
        static let headline = "headline"
        static let source = "source"
        static let related = "related"
        static let url = "url"
        static let datetime = "datetime"
    }
    
    // MARK: -  Vars

    static private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssxxxxx"
        return dateFormatter
    }
    
    /// Initiates the instance based on the JSON that was passed.
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    init?(json: JSON) {
        guard let urlString = json[SerializationKeys.url].string,
            let url = URL(string: urlString),
            let dateString = json[SerializationKeys.datetime].string,
            let date = FeedItem.dateFormatter.date(from: dateString) else {
                return nil
        }
        
        self.summary = json[SerializationKeys.summary].string
        self.headline = json[SerializationKeys.headline].string
        self.source = json[SerializationKeys.source].string
        self.url = url
        self.datetime = date
    }
    
    /// Initiates the instance based on the core data entity
    ///
    /// - parameter json: JSON object from SwiftyJSON.
    init?(entity: FeedItemEntity) {
        guard let urlString = entity.url,
            let url = URL(string: urlString),
            let date = entity.datetime else {
                return nil
        }
        
        self.summary = entity.summary
        self.headline = entity.headline
        self.source = entity.source
        self.url = url
        self.datetime = date as Date
    }
}

