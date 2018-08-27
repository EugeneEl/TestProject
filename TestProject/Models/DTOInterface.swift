//
//  DTOInterface.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 18.04.2018.
//  Copyright © 2018 Eugene Goloboyar. All rights reserved.
//

import Foundation

protocol DataObjectConfigurable {
    associatedtype DataObject
    
    func configureWithObject(_ object: DataObject)
}
