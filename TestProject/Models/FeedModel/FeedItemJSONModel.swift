//
//  FeedItemJSONModel.swift
//
//  Created by Eugene Goloboyar on 4/13/18
//  Copyright (c) . All rights reserved.
//

import Foundation

// Thanks to SwiftyJSONAccelerator)

final class FeedItemJSONModel {

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
    
  var summary: String?
  var headline: String?
  var source: String?
  var related: String?
  var url: URL
  var datetime: Date

  static private var dateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        return dateFormatter
    }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  init?(json: JSON) {
    guard let urlString = json[SerializationKeys.url].string,
        let url = URL(string: urlString),
        let dateString = json[SerializationKeys.datetime].string,
        let date = FeedItemJSONModel.dateFormatter.date(from: dateString) else {
            return nil
    }
    
    self.summary = json[SerializationKeys.summary].string
    self.headline = json[SerializationKeys.headline].string
    self.source = json[SerializationKeys.source].string
    self.related = json[SerializationKeys.related].string
    self.url = url
    self.datetime = date
  }
}

