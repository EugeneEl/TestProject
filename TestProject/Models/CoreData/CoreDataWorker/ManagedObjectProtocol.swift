//
//  ManagedObjectProtocol.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import CoreData

//extension NSManagedObject {
//    static func entityName() -> String {
//        return String(describing: self)
//    }
//}

// thanks to Michal Wojtysiak for providing approch for converting CoreData --> Plain Object
// I took this from https://swifting.io/blog/2016/11/27/28-better-coredata-with-swift-generics/

protocol ManagedObjectProtocol {
    associatedtype Entity
    func toEntity() -> Entity?
}

extension NSManagedObject {
    
    typealias CreationConfigurationBlock = (_ entity: NSManagedObject) -> ()
    
    static func findOrCreateInContext(_ context: NSManagedObjectContext, with id: String, creationConfigurationBlock: CreationConfigurationBlock?, entityName: String) -> NSManagedObject {
        let predicate = NSPredicate(format: "identifier==%@", id)
        guard let obj = findOrFetchInContext(context: context, entityName: entityName, matchingPredicate: predicate) else {
            let newObject = createEntityInContext(context: context, entityName: entityName)
            context.performAndWait {
                creationConfigurationBlock?(newObject)
            }
            return newObject
        }
        return obj
    }
    
    static func createEntityInContext(context: NSManagedObjectContext, entityName: String) -> NSManagedObject {
        let entityDescription = NSEntityDescription.entity(forEntityName: entityName, in: context);
        
        var entity: NSManagedObject?
        context.performAndWait {
            entity = NSManagedObject(entity: entityDescription!, insertInto: context)
        }
        
        return entity!
    }
    
    static func fetchInContext(_ context: NSManagedObjectContext, entityName: String, configurationBlock: (NSFetchRequest<NSFetchRequestResult>) -> () = { _ in }) -> [NSManagedObject] {
        
        let request:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        configurationBlock(request)
        
        var result = [NSManagedObject]()
        context.performAndWait() {
            guard let fetchObjects = try! context.fetch(request) as? [NSManagedObject] else { fatalError("Fetched objects have wrong type") }
            result = fetchObjects
        }
        
        return result
    }
    
    static func findOrFetchInContext(context: NSManagedObjectContext, entityName: String, matchingPredicate predicate: NSPredicate) -> NSManagedObject? {
        guard let obj = materializedObjectInContext(context, matchingPredicate: predicate) else {
            return fetchInContext(context, entityName: entityName) { request in
                request.predicate = predicate
                request.returnsObjectsAsFaults = false
                request.fetchLimit = 1
                }.first
        }
        return obj
    }
    
    static func materializedObjectInContext(_ context: NSManagedObjectContext, matchingPredicate predicate: NSPredicate) -> NSManagedObject? {
        
        var res: NSManagedObject?
        context.performAndWait {
            for obj in context.registeredObjects where !obj.isFault {
                guard let foundObject = obj as? NSManagedObject, predicate.evaluate(with: foundObject) else { continue }
                res = foundObject
            }
        }
        return res
    }
//
//    static func createDefaultFetchRequestWithName(_ entityName: String) -> NSFetchRequest<NSManagedObject> {
//        return NSFetchRequest(entityName: entityName)
//    }
    
    static func fetchAllInContext(context: NSManagedObjectContext, entityName: String) -> [NSManagedObject] {
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        print("request: \(request)")
        request.returnsObjectsAsFaults = true
        request.includesPropertyValues = false
        
        var fetchObjects: [NSManagedObject]?
        context.performAndWait {
            guard let result = try! context.fetch(request) as? [NSManagedObject] else { fatalError("Fetched objects have wrong type") }
            fetchObjects = result
        }
        
        return fetchObjects!
    }
    
    static func deleteAllInContext(context: NSManagedObjectContext, entityName: String) {
        context.performAndWait {
            let fetchedObjects = fetchAllInContext(context: context, entityName: entityName)
            
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
