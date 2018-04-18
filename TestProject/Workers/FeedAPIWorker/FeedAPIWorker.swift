//
//  FeedAPIWorker.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 18.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

final class FeedAPIWorker {
    
    // MARK: - Vars
    
    fileprivate let networkService: NetworkService = ServiceLocator.inject()
    
    // MARK: - Public
    
    func fetchNews() {
        let path = "stock/market/news/last/100"
        
        networkService.GET(path, parameters: nil, headers: nil, encoding: .urlEncoded, withAuthorization: true) { (result) in
            switch result {
            case .success(let rawData):
                let json = JSON(data: rawData!, error: nil)

                print(json)
            case .failure(let errorJSON, let errorString):
                print(errorString)
                //failure(errorString ?? ErrorConstants.baseError)
            }
        }
    }
}
