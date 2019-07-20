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

extension UserEntity: ManagedObjectProtocol {
    func toPlainObject() -> User? {
        return User(entity: self)
    }
}

extension User: PlainObjectConvertible {    
    func toManagedObject(in context: NSManagedObjectContext) -> UserEntity? {
        // TEST StockAPI doesn't provide ids do I will use URL as keys
        let entity = UserEntity.getOrCreateSingle(with: identifier, from: context)
        entity.email = email
        
        return entity
    }
}

