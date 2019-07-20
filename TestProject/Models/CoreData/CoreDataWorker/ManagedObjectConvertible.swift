//
//  ManagedObjectConvertible.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import CoreData

// thanks to Michal Wojtysiak for providing approch for converting CoreData --> Plain Object
// I took this from https://swifting.io/blog/2016/11/27/28-better-coredata-with-swift-generics/

protocol PlainObjectConvertible {
    associatedtype ManagedObject: NSManagedObject, ManagedObjectProtocol
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}
