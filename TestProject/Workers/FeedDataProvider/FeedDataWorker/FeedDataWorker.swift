//
//  FeedDataWorker.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

protocol FeedDataControllerProtocol {
    func fetchItems(completion: @escaping ([FeedItem]) -> Void)
    func updateItems(items: [FeedItem])
    func deleteItems(completion: @escaping () -> Void)
}

class FeedDataWorker: FeedDataControllerProtocol {

    // MAKR: - Vars
    
    private let worker: NewCoreDataWorkerProtocol
 
    // MARK: - Initialization
    
    init(worker: NewCoreDataWorkerProtocol = NewCoreDataWorker()){
        self.worker = worker
    }
    
    // MARK: - Public
    
    func fetchItems(completion: @escaping ([FeedItem]) -> Void) {
        worker.get{(result: Result<[FeedItem]>) in
            switch result {
            case .success(let items):
                completion(items)
            case .failure(let error):
                print("\(error)")
                completion([])
            }
        }
    }
    
    func updateItems(items: [FeedItem]){
        worker.upsert(entities: items) { (error) in
            guard let error = error else { return }
            print("\(error)")
        }
    }
    
    func deleteItems(completion: @escaping () -> Void) {
        worker.delete {(result: Result<[FeedItem]>) in
            completion()
        }
    }
}
