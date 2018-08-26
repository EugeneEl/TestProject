//
//  CoreDataWorker.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import CoreData

// thanks to Michal Wojtysiak for providing approch for converting CoreData --> Plain Object
// I took this from https://swifting.io/blog/2016/11/27/28-better-coredata-with-swift-generics/

enum Result<T>{
    case success(T)
    case failure(Error)
}


protocol NewCoreDataWorkerProtocol {
    func get<Entity: ManagedObjectConvertible>
        (with predicate: NSPredicate?,
         sortDescriptors: [NSSortDescriptor]?,
         fetchLimit: Int?,
         completion: @escaping (Result<[Entity]>) -> Void)
    func upsert<Entity: ManagedObjectConvertible>
        (entities: [Entity],
         completion: @escaping (Error?) -> Void)
    func delete<Entity: ManagedObjectConvertible>
        (completion: @escaping (Result<[Entity]>) -> Void)
}

extension NewCoreDataWorkerProtocol {
    func get<Entity: ManagedObjectConvertible>
        (with predicate: NSPredicate? = nil,
         sortDescriptors: [NSSortDescriptor]? = nil,
         fetchLimit: Int? = nil,
         completion: @escaping (Result<[Entity]>) -> Void) {
        get(with: predicate,
            sortDescriptors: sortDescriptors,
            fetchLimit: fetchLimit,
            completion: completion)
    }
}

enum CoreDataWorkerError: Error{
    case cannotFetch(String)
    case cannotSave(Error)
    case cannotDelete(Error)
}

class NewCoreDataWorker: NewCoreDataWorkerProtocol {
    
    let coreData: CoreDataServiceProtocol
    
    init(coreData: CoreDataServiceProtocol = CoreDataService.shared) {
        self.coreData = coreData
    }
    
    func get<Entity: ManagedObjectConvertible>
        (with predicate: NSPredicate?,
         sortDescriptors: [NSSortDescriptor]?,
         fetchLimit: Int?,
         completion: @escaping (Result<[Entity]>) -> Void) {
        coreData.performForegroundTask { context in
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.ManagedObject.entityName())
                
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = sortDescriptors
                if let fetchLimit = fetchLimit {
                    fetchRequest.fetchLimit = fetchLimit
                }
                let results = try context.fetch(fetchRequest) as? [Entity.ManagedObject]
                let items: [Entity] = results?.flatMap { $0.toEntity() as? Entity } ?? []
                completion(.success(items))
            } catch {
                let fetchError = CoreDataWorkerError.cannotFetch("Cannot fetch error: \(error))")
                completion(.failure(fetchError))
            }
        }
    }
    
    func upsert<Entity: ManagedObjectConvertible>
        (entities: [Entity],
         completion: @escaping (Error?) -> Void) {
        
        coreData.performBackgroundTask { context in
            let objects = entities.flatMap({ (entity) -> Entity.ManagedObject? in
                return entity.toManagedObject(in: context)
            })
            do {
                try context.save()
                completion(nil)
            } catch {
                completion(CoreDataWorkerError.cannotSave(error))
            }
        }
    }
    
    func delete<Entity>(completion: @escaping (Result<[Entity]>) -> Void) where Entity : ManagedObjectConvertible {
        coreData.performForegroundTask { context in
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity.ManagedObject.entityName())
                let results = try context.fetch(fetchRequest) as? [Entity.ManagedObject]
                
                guard let savedObjects = results else {
                    print("nothing to delete")
                    completion(.success([]))
                    return
                }
                
                for obj in savedObjects {
                    context.delete(obj)
                }
                do {
                    try context.save()
                    print("success delete")
                    completion(.success([]))
                } catch {
                    completion(.failure(error))
                }
            } catch {
                let fetchError = CoreDataWorkerError.cannotFetch("Cannot fetch error: \(error))")
                completion(.failure(fetchError))
            }
        }
    }
}
