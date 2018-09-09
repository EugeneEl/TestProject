//
//  UserEntity+CoreDataClass.swift
//  
//
//  Created by Eugene Goloboyar on 02.09.2018.
//
//

import Foundation
import CoreData


public class UserEntity: NSManagedObject {

}

//extension UserEntity: ManagedObjectProtocol {
//    func toEntity() -> User? {
//        return User(entity: self)
//    }
//}
//
//extension User: ManagedObjectConvertible {
//    func toManagedObject(in context: NSManagedObjectContext) -> UserEntity? {
//        // TEST StockAPI doesn't provide ids do I will use URL as keys
//        let entity = UserEntity.cr
//        entity.email = email
//        
//        return entity
//    }
//    
//    var entityName: String {
//        return "UserEntity"
//    }
//}

