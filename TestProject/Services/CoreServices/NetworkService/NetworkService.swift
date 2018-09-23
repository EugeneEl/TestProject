//
//  NetworkService.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 17.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

enum DataRequestResult {
    case success(Data?)
    case failure(Data?, String?, Int?)
}

/// Parameters encoding type.
///
/// - json: JSON encoding for parameters.
/// - urlEncoded: URL encoding for parameters.
enum ParametersEncoding {
    case json
    case urlEncoded
}

protocol Cancellable {
    func cancelRequest()
}

typealias DataRequestCallback = (_ result: DataRequestResult) -> ()

protocol NetworkService {
    
    func GET( _ path: String,
              parameters: [String : AnyObject]?,
              headers: [String : String]?,
              encoding: ParametersEncoding,
              withAuthorization: Bool,
              callback: @escaping DataRequestCallback) -> Cancellable?
    
    func POST( _ path: String,
               parameters: [String : AnyObject]?,
               headers: [String : String]?,
               encoding: ParametersEncoding,
               data: [Data], withAuthorization: Bool,
               callback: @escaping DataRequestCallback) -> Cancellable?
    
    func PUT( _ path: String,
              parameters: [String : AnyObject]?,
              headers: [String : String]?,
              encoding: ParametersEncoding,
              data: [Data],
              withAuthorization: Bool,
              callback: @escaping DataRequestCallback) -> Cancellable?
    
    func PATCH(_ path: String,
               parameters: [String : AnyObject]?,
               headers: [String : String]?,
               encoding: ParametersEncoding,
               data: [Data],
               withAuthorization: Bool,
               callback: @escaping DataRequestCallback) -> Cancellable?
    
    func DELETE(_ path: String,
                parameters: [String : AnyObject]?,
                headers: [String : String]?,
                withAuthorization: Bool,
                encoding: ParametersEncoding,
                callback: @escaping DataRequestCallback) -> Cancellable?
    
}
