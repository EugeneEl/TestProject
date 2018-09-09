//
//  ManagedObjectProtocol.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 26.08.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation
import CoreData

//extension NSManagedObject {
//    static func entityName() -> String {
//        return String(describing: self)
//    }
//}

// thanks to Michal Wojtysiak for providing approch for converting CoreData --> Plain Object
// I took this from https://swifting.io/blog/2016/11/27/28-better-coredata-with-swift-generics/

protocol ManagedObjectProtocol {
    associatedtype Entity
    func toEntity() -> Entity?
}

//
//extension NSManagedObject {
//    static func findOrCreateInContext(_ context: NSManagedObjectContext, enityName: String, id: String) -> NSManagedObject {
//        let predicate = NSPredicate(format: "identifier == %@", id)
//    }
//}

