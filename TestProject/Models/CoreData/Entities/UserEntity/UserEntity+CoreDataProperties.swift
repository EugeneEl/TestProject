//
//  UserEntity+CoreDataProperties.swift
//  
//
//  Created by Eugene Goloboyar on 02.09.2018.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var email: String?
    @NSManaged public var identifier: String?

}
