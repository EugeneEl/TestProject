//
//  ListWorkersFactory..swift
//  TestProject
//
//  Created by Eugene Goloboyar on 7/20/19.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class ListWorkersFactory {
    
    // MARK: - Public
    
    static func buildFeedAPIWorker() -> FeedAPIProtocol {
        switch AppConfigurationProvider.shared.configuration {
        case .test:
            return FeedAPIWorkerJSON()
        case .debug:
            return FeedAPIWorkerJSON()
        case .adhoc:
            return FeedAPIWorkerJSON()
        case .release:
            return FeedAPIWorkerJSON()
        }
    }
    
}
