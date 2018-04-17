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
    case failure(Data?, String?)
}

/// Parameters encoding type.
///
/// - json: JSON encoding for parameters.
/// - urlEncoded: URL encoding for parameters.
enum ParametersEncoding {
    case json
    case urlEncoded
}

typealias DataRequestCallback = (_ result: DataRequestResult) -> ()

protocol NetworkService {
    
    func GET( _ path: String,
              parameters: [String : AnyObject]?,
              headers: [String : String]?,
              encoding: ParametersEncoding,
              withAuthorization: Bool,
              callback: @escaping DataRequestCallback) -> ()
    
    func POST( _ path: String,
               parameters: [String : AnyObject]?,
               headers: [String : String]?,
               encoding: ParametersEncoding,
               data: [Data], withAuthorization: Bool,
               callback: @escaping DataRequestCallback) -> ()
    
    func PUT( _ path: String,
              parameters: [String : AnyObject]?,
              headers: [String : String]?,
              encoding: ParametersEncoding,
              data: [Data],
              withAuthorization: Bool,
              callback: @escaping DataRequestCallback) -> ()
    
    func PATCH(_ path: String,
               parameters: [String : AnyObject]?,
               headers: [String : String]?,
               encoding: ParametersEncoding,
               data: [Data],
               withAuthorization: Bool,
               callback: @escaping DataRequestCallback) -> ()
    
    func DELETE(_ path: String,
                parameters: [String : AnyObject]?,
                headers: [String : String]?,
                withAuthorization: Bool,
                encoding: ParametersEncoding,
                callback: @escaping DataRequestCallback) -> ()
    
}
