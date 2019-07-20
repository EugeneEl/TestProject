//
//  FeedItemEntity+CoreDataProperties.swift
//  
//
//  Created by Eugene Goloboyar on 26.08.2018.
//
//

import Foundation
import CoreData

extension FeedItemEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FeedItemEntity> {
        return NSFetchRequest<FeedItemEntity>(entityName: "FeedItemEntity")
    }
    
    @NSManaged public var summary: String?
    @NSManaged public var headline: String?
    @NSManaged public var url: String?
    @NSManaged public var datetime: NSDate?
    @NSManaged public var source: String?
    @NSManaged public var identifier: String
}
