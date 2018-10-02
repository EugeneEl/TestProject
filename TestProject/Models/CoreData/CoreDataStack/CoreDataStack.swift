//
//  CoreDataStack.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import CoreData

protocol CoreDataServiceProtocol:class {
    var errorHandler: (Error) -> Void {get set}
    var persistentContainer: NSPersistentContainer {get}
    var viewContext: NSManagedObjectContext {get}
    var backgroundContext: NSManagedObjectContext {get}
    
    func performTaskOnDataOperationQueue(_ dataOperationType: DataOperationQueueType, _ block: @escaping (NSManagedObjectContext) -> Void)
    func performForegroundTaskAndWait(_ block: @escaping (NSManagedObjectContext) -> Void)
}


final class CoreDataService: CoreDataServiceProtocol {
    
    static let shared = CoreDataService()
    var errorHandler: (Error) -> Void = {_ in }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TestProject")
        container.loadPersistentStores(completionHandler: { [weak self](storeDescription, error) in
            if let error = error {
                NSLog("CoreData error \(error), \(error._userInfo)")
                self?.errorHandler(error)
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        let context:NSManagedObjectContext = self.persistentContainer.viewContext
        context.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    lazy var backgroundContext: NSManagedObjectContext = {
        return self.persistentContainer.newBackgroundContext()
    }()
    
    func performTaskOnDataOperationQueue(_ dataOperationType: DataOperationQueueType, _ block: @escaping (NSManagedObjectContext) -> Void) {
        switch dataOperationType {
        case .main:
            viewContext.performAndWait {block(self.viewContext)}
        case .background:
            persistentContainer.performBackgroundTask(block)
        }
    }
    
    func performForegroundTaskAndWait(_ block: @escaping (NSManagedObjectContext) -> Void) {
        self.viewContext.performAndWait {
            block(self.viewContext)
        }
    }
}
