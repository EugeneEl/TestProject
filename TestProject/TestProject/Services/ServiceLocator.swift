//
//  ServiceLocator.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 29.03.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

// http://www.floriangoessler.de/ios/2016/01/24/Swift-Service-Locator.html

/// ServiceLocator class is an implementation of Service Locator pattern. Container with dependencies where key is some "id" of interface and value is some instance implementing this interface. Classes with higher level of abstraction (as 'workers') just inject proper dependencies via interface without knowing about internal details of other classes serves as dependency.
open class ServiceLocator {
    
    fileprivate var registry = [ObjectIdentifier : Any]()
    
    open static var sharedLocator = ServiceLocator()
    
    // MARK: Registration
    
    open func register<Service>(_ factory: @escaping () -> Service) {
        let serviceId = ObjectIdentifier(Service.self)
        registry[serviceId] = factory
    }
    
    /// Register Singleton for `Service` key in container.
    ///
    /// - Parameter singletonInstance: An instance implementing `Service` protocol.
    open func registerSingleton<Service>(_ singletonInstance: Service) {
        let serviceId = ObjectIdentifier(Service.self)
        registry[serviceId] = singletonInstance
    }
    
    open static func registerSingleton<Service>(_ singletonInstance: Service) {
        sharedLocator.registerSingleton(singletonInstance)
    }
    
    // MARK: Injection
    
    /// Inject proper instance implementing `Serive` interface.
    ///
    /// - Returns: An instance implementing `Service` protocol.
    open static func inject<Service>() -> Service {
        return sharedLocator.inject()
    }
    
    // This method is private because no service which wants to request other services should
    // bind itself to specific instance of a service locator.
    fileprivate func inject<Service>() -> Service {
        let serviceId = ObjectIdentifier(Service.self)
        if let factory = registry[serviceId] as? () -> Service {
            return factory()
        } else if let singletonInstance = registry[serviceId] as? Service {
            return singletonInstance
        } else {
            fatalError("No registered entry for \(Service.self)")
        }
    }
    
}
