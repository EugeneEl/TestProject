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
        let predicate = NSPredicate(format: "identifier == %@", url.absoluteString)
        let item = FeedItemEntity.findOrCreateInContext(context, with: url.absoluteString, creationConfigurationBlock: { (feedItemEntity) in
            if let entity = feedItemEntity as? FeedItemEntity {
                entity.source = self.source
                entity.headline = self.headline
                entity.datetime = self.datetime as? NSDate
                entity.summary = self.summary
                entity.identifier = self.url.absoluteString
                entity.url = self.url.absoluteString
            }
        }, entityName: "FeedItemEntity")

        return item as? FeedItemEntity
    }
    
    static var entityName: String {
        return "FeedItemEntity"
    }
}

