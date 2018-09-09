//
//  FeedItemEntity+CoreDataClass.swift
//  
//
//  Created by Eugene Goloboyar on 26.08.2018.
//
//

import Foundation
import CoreData

@objc(FeedItemEntity)
public class FeedItemEntity: NSManagedObject {

}

extension FeedItemEntity: ManagedObjectProtocol {
    func toEntity() -> FeedItem? {
        return FeedItem(entity: self)
    }
}

extension FeedItem: ManagedObjectConvertible {
    func toManagedObject(in context: NSManagedObjectContext) -> FeedItemEntity? {
        // TEST StockAPI doesn't provide ids do I will use URL as keys
        let item = FeedItemEntity.getOrCreateSingle(with: url.absoluteString, from: context)
        
        item.datetime = datetime as NSDate?
        item.summary = summary
        item.headline = headline
        item.url = url.absoluteString
        item.source = source
        return item
    }
    
    var entityName: String {
        return "FeedItemEntity"
    }
}

