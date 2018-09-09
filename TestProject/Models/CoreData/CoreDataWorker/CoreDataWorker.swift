//
//  CoreDataWorker.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import CoreData

enum Result<T>{
    case success(T)
    case failure(Error)
}

enum CoreDataWorkerError: Error{
    case cannotFetch(String)
    case cannotSave(Error)
    case cannotDelete(Error)
}

protocol FeedItemDataWorkerProtocol {
    func getFeedItems(completion: @escaping ([FeedItem]) -> Void)
    func updateFeedItems(_ feedItems: [FeedItem], completion: @escaping (Error?) -> Void)
    func deleteFeedItems(completion: @escaping (Error?) -> Void)
}

class FeedItemDataWorker: FeedItemDataWorkerProtocol {
    
    let coreData: CoreDataServiceProtocol
    
    init(coreData: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreData = coreData
    }
    
    func getFeedItems(completion: @escaping ([FeedItem]) -> Void) {
        coreData.performForegroundTask { (context) in
            if let feedbackCoreDataItems = FeedItemEntity.fetchAllInContext(context: context, entityName: FeedItem.entityName) as? [FeedItemEntity] {
                let items = feedbackCoreDataItems.flatMap({FeedItem(entity: $0)})
                completion(items)
            } else {
                completion([])
            }
        }
    }
    
    func updateFeedItems(_ feedItems: [FeedItem], completion: @escaping (Error?) -> Void) {
        coreData.performForegroundTask { (context) in
            
            feedItems.forEach({ (item) in
                item.toManagedObject(in: context)
            })
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(CoreDataWorkerError.cannotSave(error))
            }
            print("success save")
        }
    }
    
    func deleteFeedItems(completion: @escaping (Error?) -> Void) {
        coreData.performForegroundTask { context in
            FeedItemEntity.deleteAllInContext(context: context, entityName: FeedItem.entityName)
                do {
                    try context.save()
                    print("success delete")
                     completion(nil)
                } catch {
                     completion(error)
                }
        }
    }
}

