//
//  String+Validation.swift
//  EGS
//

import Foundation

extension String {

    func isValidEmail() -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"

        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    
    var length: Int {
        return self.characters.count
    }
    
    var nsstringLength: Int {
        return (self as NSString).length
    }
    
    static func encodeByAddingPercentEscapes(_ input: String) -> String? {
        return NSString(string: input).addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]"))
    }

}
