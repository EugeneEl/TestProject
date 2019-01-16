//
//  String+Extensions.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 16.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation

extension String {
    static func provideWithoutExtraWhitespaces(_ text: String) -> String {
        let charset = CharacterSet.whitespacesAndNewlines
        let noEmptyStringsPredicate = NSPredicate(format: "SELF != ''")
        
        let parts = text.components(separatedBy: charset)
        
        let filteredArray = (parts as NSArray).filtered(using: noEmptyStringsPredicate) as NSArray
        
        return filteredArray.componentsJoined(by: " ")
    }
    
    func isNumeric() -> Bool {
        guard self.characters.count > 0 else { return true}
        let nums: Set<Character> = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9"]
        return Set(self.characters).isSubset(of: nums)
    }
}

