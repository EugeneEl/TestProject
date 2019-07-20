//
//  ManagedObjectProtocol.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import CoreData

// thanks to Michal Wojtysiak for providing approch for converting CoreData --> Plain Object
// I took this from https://swifting.io/blog/2016/11/27/28-better-coredata-with-swift-generics/

protocol ManagedObjectProtocol {
    associatedtype PlainObject
    func toPlainObject() -> PlainObject?
}

extension NSManagedObject {
    class func entityName() -> String {
        return String(describing: self)
    }
}

extension ManagedObjectProtocol where Self: NSManagedObject {
    
    static func getOrCreateSingle(with id: String, from context: NSManagedObjectContext) -> Self {
        let result = single(with: id, from: context) ?? insertNew(in: context)
        result.setValue(id, forKey: "identifier")
        return result
    }
    
    static func single(from context: NSManagedObjectContext, with predicate: NSPredicate?,
                       sortDescriptors: [NSSortDescriptor]?) -> Self? {
        return fetch(from: context, with: predicate,
                     sortDescriptors: sortDescriptors, fetchLimit: 1)?.first
    }
    
    static func single(with id: String, from context: NSManagedObjectContext) -> Self? {
        let predicate = NSPredicate(format: "identifier == %@", id)
        return single(from: context, with: predicate, sortDescriptors: nil)
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self {
        let entityDescription = NSEntityDescription.entity(forEntityName: Self.entityName(), in: context);
        
        var entity: Self?
        context.performAndWait {
            entity = Self(entity: entityDescription!, insertInto: context)
        }
        
        return entity!
    }
    
    static func fetch(from context: NSManagedObjectContext, with predicate: NSPredicate?,
                      sortDescriptors: [NSSortDescriptor]?, fetchLimit: Int?) -> [Self]? {
        
        var result: [Self]?
        context.performAndWait { () -> Void in
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:Self.entityName())
            fetchRequest.sortDescriptors = sortDescriptors
            fetchRequest.predicate = predicate
            fetchRequest.returnsObjectsAsFaults = false
            print("fetchRequest: \(fetchRequest)")
            
            if let fetchLimit = fetchLimit {
                fetchRequest.fetchLimit = fetchLimit
            }
            
            do {
                print(fetchRequest)
                result = try context.fetch(fetchRequest) as? [Self]
            } catch {
                result = nil
                //Report Error
                print("CoreData fetch error \(error)")
            }
        }
        return result
    }
}

extension ManagedObjectProtocol where Self: NSManagedObject {
    static func createDefaultFetchRequest() -> NSFetchRequest<Self> {
        return NSFetchRequest(entityName: entityName())
    }
    
    static func fetchAllInContext(context: NSManagedObjectContext) -> [Self] {
        let request = Self.createDefaultFetchRequest()
        
        request.returnsObjectsAsFaults = true
        request.includesPropertyValues = false
        
        var fetchObjects: [Self]?
        context.performAndWait {
            guard let result = try! context.fetch(request) as? [Self] else { fatalError("Fetched objects have wrong type") }
            fetchObjects = result
        }
        
        return fetchObjects!
    }
    
    static func deleteAllInContext(context: NSManagedObjectContext) {
        context.performAndWait {
            let fetchedObjects = Self.fetchAllInContext(context: context)
            
            if fetchedObjects.count > 0 {
                context.performAndWait {
                    for obj in fetchedObjects {
                        context.delete(obj)
                    }
                }
            }
        }
    }
}

