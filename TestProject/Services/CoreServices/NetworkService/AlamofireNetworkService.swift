//
//  AlamofireNetworkService.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 17.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireNetworkClient {
    
    // MARK: - Vars
    
    static let shared = AlamofireNetworkClient("Test", url: "mockedURL")
    fileprivate let baseURL: String
    
    fileprivate let manager = Alamofire.SessionManager.default
    
    // MARK: - Initialization
    
    private init () {
        manager = Alamofire.SessionManager.default
        manager.setHeader("application/json", key: "Content-Type")
    }
    
    fileprivate func generalRequestWithPath( _ path: String, method: HTTPMethod, encoding: ParametersEncoding, parameters: [String : AnyObject]?, data: [Data], headers: [String : String]?, withAuthorization: Bool, callback: @escaping DataRequestCallback) -> URLSessionTask? {
        
        if BaseReachabilityService.sharedReachabilityService.isConnected() == false {
            callback(.failure(nil, ErrorConstants.noConnection))
            return nil
        }
        
        if baseURL == NetworkClient.mockedURLKey {
            callback(.failure(nil, "Open 311 is not configured"))
            return nil
        }
        
        let finalURL = buildFinalURL()
        
        guard let url = finalURL else {
            callback(.failure(nil, "Cannot build URL"))
            return nil
        }
        
        var requestParameters = parameters ?? [String : AnyObject]()
        if withAuthorization {
            if let authKey = key {
                requestParameters[apiKey] = authKey as AnyObject
            }
        }
        
        var requestTask: DataRequest? = nil
        
        let completionHandler: ((DataResponse<Data>) -> Void) = { (dataResponse) in
            guard let response = dataResponse.response else {
                callback(DataRequestResult.failure(nil, ErrorConstants.baseError))
                return
            }
            
            
            let statusCode = response.statusCode
            let validCodes = Array(200..<300)
            if validCodes.contains(statusCode) {
                callback(DataRequestResult.success(dataResponse.data))
                return
            } else {
                if let error = dataResponse.result.error {
                    let code = (error as NSError).code
                    if code == -1003 || code == -1005 || code == -1009 || code == -999  {
                        callback(DataRequestResult.failure(nil, ErrorConstants.noConnection))
                        return
                    }
                }
                
                if let data = dataResponse.data {
                    let errorString = NetworkClient.convertErrorData(data: data)
                    callback(DataRequestResult.failure(data, errorString))
                    return
                }
                
                
                callback(DataRequestResult.failure(nil, ErrorConstants.baseError))
                return
            }
            
        }
        
        switch encoding {
        case .json:
            requestTask = manager.request(url, method: method, parameters: requestParameters, encoding: JSONEncoding.default, headers: headers)
        case .urlEncoded:
            requestTask = manager.request(url, method: method, parameters: requestParameters, headers: headers)
        
        requestTask?.validate().responseData(completionHandler: completionHandler)
        
        return requestTask?.task
    }
    
    fileprivate static func convertErrorData(data: Data?) -> String {
        guard let errorData = data else {
            return ErrorConstants.baseError
        }
        
        let json = JSON(data: errorData, error: nil)
        
        var errorCode: String? = nil
        var errorDescription: String? = nil
        for subjson in json {
            if let code = subjson.1["code"].int {
                errorCode = "\(code)"
            }
            
            if let error = subjson.1["description"].string {
                errorDescription = error
            }
        }
        
        guard let code = errorCode, let errorText = errorDescription else {
            return ErrorConstants.baseError
        }
        
        return "ErrorCode: \(code) Description: \(errorText)"
    }
}


// MARK: - OpenFeedbackNetworkService

extension AlamofireNetworkClient: NetworkService {
    func GET( _ path: String,
              parameters: [String : AnyObject]?,
              headers: [String : String]?,
              encoding: ParametersEncoding,
              withAuthorization: Bool,
              callback: @escaping DataRequestCallback) -> () {
        
    }
    
    func POST( _ path: String,
               parameters: [String : AnyObject]?,
               headers: [String : String]?,
               encoding: ParametersEncoding,
               data: [Data], withAuthorization: Bool,
               callback: @escaping DataRequestCallback) -> () {
        
    }
    
    func PUT( _ path: String,
              parameters: [String : AnyObject]?,
              headers: [String : String]?,
              encoding: ParametersEncoding,
              data: [Data],
              withAuthorization: Bool,
              callback: @escaping DataRequestCallback) -> () {
        
    }
    
    func PATCH(_ path: String,
               parameters: [String : AnyObject]?,
               headers: [String : String]?,
               encoding: ParametersEncoding,
               data: [Data],
               withAuthorization: Bool,
               callback: @escaping DataRequestCallback) -> () {
        
    }
    
    func DELETE(_ path: String,
                parameters: [String : AnyObject]?,
                headers: [String : String]?,
                withAuthorization: Bool,
                encoding: ParametersEncoding,
                callback: @escaping DataRequestCallback) -> () {
        
    }
}
