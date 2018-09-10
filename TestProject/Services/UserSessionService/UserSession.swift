//
//  UserSession.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 09.09.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

struct DataWorkers {
    
    let feedbackDataWorker = FeedDataProvider(dataWorker: FeedDataWorker(),
                                              apiWorker: FeedAPIWorker())
}

final class UserSession {
    
    let workers = DataWorkers()
    let identifier: String
    
    // MARK: - Initialization
    
    init(identifier: String) {
        self.identifier = identifier
    }
    
    // MARK: - Public
    
    func closeSession() {
        workers.feedbackDataWorker.clearData()
    }
}
