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
    case success(T?)
    case failure(Error)
}

enum DataFetchOperationType {
    case main
    case background
}

protocol NewCoreDataWorkerProtocol {
    func get<PlainObject: PlainObjectConvertible>
        (with predicate: NSPredicate?,
         sortDescriptors: [NSSortDescriptor]?,
         fetchLimit: Int?,
         operationQueue: DataFetchOperationType,
         completion: @escaping (Result<[PlainObject]>) -> ())
    func upsert<PlainObject: PlainObjectConvertible>
        (entities: [PlainObject],
         operationQueue: DataFetchOperationType,
         completion: @escaping (Error?) -> ())
    func deleteAll<PlainObject: PlainObjectConvertible>
        (operationQueue: DataFetchOperationType,
         completion: @escaping (Result<[PlainObject]>) -> ())
    
    func getById<PlainObject: PlainObjectConvertible>(id: String,
                                                      operationQueue: DataFetchOperationType,
                                                      completion: @escaping(Result<PlainObject>)-> ())
    func updateByPlainObject<PlainObject: PlainObjectConvertible>(item: PlainObject,
                                                                  operationQueue: DataFetchOperationType, completion: @escaping(Result<PlainObject>)-> ())
    func deleteById<PlainObject: PlainObjectConvertible>(id: String,
                                                         operationQueue: DataFetchOperationType,
                                                         completion: @escaping (Result<PlainObject>) -> ())
}

extension NewCoreDataWorkerProtocol {
    func get<PlainObject: PlainObjectConvertible>
        (with predicate: NSPredicate? = nil,
         sortDescriptors: [NSSortDescriptor]? = nil,
         fetchLimit: Int? = nil,
         operationQueue: DataFetchOperationType = .main,
         completion: @escaping (Result<[PlainObject]>) -> Void) {
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
    
    func get<PlainObject: PlainObjectConvertible>
        (with predicate: NSPredicate?,
         sortDescriptors: [NSSortDescriptor]?,
         fetchLimit: Int?,
         operationQueue: DataFetchOperationType,
         completion: @escaping (Result<[PlainObject]>) -> Void) {
        coreData.performTaskOnDataOperationQueue(operationQueue) { context in
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PlainObject.ManagedObject.entityName())
                
                fetchRequest.predicate = predicate
                fetchRequest.sortDescriptors = sortDescriptors
                if let fetchLimit = fetchLimit {
                    fetchRequest.fetchLimit = fetchLimit
                }
                let results = try context.fetch(fetchRequest) as? [PlainObject.ManagedObject]
                let items: [PlainObject] = results?.flatMap { $0.toPlainObject() as? PlainObject } ?? []
                completion(.success(items))
            } catch {
                let fetchError = CoreDataWorkerError.cannotFetch("Cannot fetch error: \(error))")
                completion(.failure(fetchError))
            }
        }
    }
    
    func upsert<PlainObject: PlainObjectConvertible>
        (entities: [PlainObject],          operationQueue: DataFetchOperationType,
         completion: @escaping (Error?) -> Void) {
        
        coreData.performTaskOnDataOperationQueue(operationQueue) { context in
            let objects = entities.flatMap({ (entity) -> PlainObject.ManagedObject? in
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
    
    func getById<PlainObject: PlainObjectConvertible>(id: String,          operationQueue: DataFetchOperationType, completion: @escaping(Result<PlainObject>)-> ()) {
        coreData.performForegroundTaskAndWait { (context) in
            let entity = PlainObject.ManagedObject.single(with: id, from: context) as? PlainObject.ManagedObject
            let plainObject = entity?.toPlainObject() as? PlainObject
            let result = Result.success(plainObject)
            completion(result)
        }
    }
    
    func updateByPlainObject<PlainObject>(item: PlainObject,          operationQueue: DataFetchOperationType, completion: @escaping (Result<PlainObject>) -> ()) where PlainObject : PlainObjectConvertible {
        coreData.performTaskOnDataOperationQueue(operationQueue) { context in
            let object = item.toManagedObject(in: context)
            do {
                try context.save()
                completion(Result.success(object?.toPlainObject() as? PlainObject))
            } catch {
                completion(Result.failure(error))
            }
        }
    }
    
    func deleteById<PlainObject: PlainObjectConvertible>(id: String,          operationQueue: DataFetchOperationType, completion: @escaping (Result<PlainObject>) -> ()) {
        coreData.performTaskOnDataOperationQueue(operationQueue) { context in
            do {
                let entity = PlainObject.ManagedObject.single(with: id, from: context) as? PlainObject.ManagedObject
                
                guard let managedObject = entity else {
                    print("nothing to delete")
                    completion(.success(nil))
                    return}
                
                context.delete(managedObject)
                
                do {
                    try context.save()
                    print("success delete")
                    completion(.success(nil))
                } catch {
                    completion(.failure(error))
                }
            } catch {
                let fetchError = CoreDataWorkerError.cannotFetch("Cannot fetch error: \(error))")
                completion(.failure(fetchError))
            }
        }
    }
    
    func deleteAll<PlainObject>(operationQueue: DataFetchOperationType, completion: @escaping (Result<[PlainObject]>) -> Void) where PlainObject : PlainObjectConvertible {
        coreData.performTaskOnDataOperationQueue(operationQueue) { context in
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: PlainObject.ManagedObject.entityName())
                let results = try context.fetch(fetchRequest) as? [PlainObject.ManagedObject]
                
                guard let savedObjects = results else {
                    print("nothing to delete")
                    completion(.success([]))
                    return
                }
                
                print("savedObjects: \(savedObjects.count)")
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



