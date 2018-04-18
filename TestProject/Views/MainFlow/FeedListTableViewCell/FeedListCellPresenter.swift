//
//  FeedListCellPresenter.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 18.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

/// `FeedListCellPresenter` encapsulates logic for formatting data in `FeedListTableViewCell`
final class FeedListCellPresenter {
 
    // MARK: - Vars
    
    static private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = .short
        dateFormatter.dateStyle = .short
        
        return dateFormatter
    }
    
    // MARK: - Public
    
    /// Provide text for date in news object `FeedItemJSONModel`.
    ///
    /// - Parameter feed: `FeedItemJSONModel` to provide date.
    /// - Returns: `String?` with date text.
    static func provideDateTextForFeedItem(_ feed: FeedItemJSONModel) -> String? {
        return dateFormatter.string(from: feed.datetime)
    }
}
