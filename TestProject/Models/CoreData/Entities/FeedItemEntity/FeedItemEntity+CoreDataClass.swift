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
        let entity = FeedItemEntity.getOrCreateSingle(with: url.absoluteString, from: context)
        entity.source = self.source
        entity.headline = self.headline
        entity.datetime = self.datetime as? NSDate
        entity.summary = self.summary
        entity.identifier = self.url.absoluteString
        entity.url = self.url.absoluteString

        return entity
    }
    
    static var entityName: String {
        return "FeedItemEntity"
    }
}

