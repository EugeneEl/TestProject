//
//  FormValidators.swift
//  TestProject
//
//  Created by Eugene Goloboyar on 16.01.2019.
//  Copyright © 2019 Eugene Goloboyar. All rights reserved.
//

import Foundation

struct PasswordValidationRules {
    static let minPassword = 6
    static let maxPassowrd = 64
    static let maxName = 64
    static let minName = 3
}

protocol StringValidatable {
    func isStringValid(_ text: String) -> Bool
}

final class EmailValidationRule: StringValidatable {
    func isStringValid(_ text: String) -> Bool {
        
        return EmailValidationRule.isValidEmail(text)
    }
    
    static private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: email)
    }
}

final class OnlyNumbersValidationRule: StringValidatable {
    func isStringValid(_ text: String) -> Bool {
        return text.isNumeric()
    }
}

final class ConfirmPasswordRule: StringValidatable {
    
    // MARK: - Vars:
    
    var password: String = ""
    
    
    func isStringValid(_ text: String) -> Bool {
        return password == text
    }
}

final class MaxNumberValidationRule: StringValidatable {
    
    // MARK: - Vars
    
    let maxChars: Int
    
    // MARK: - Initialization
    
    init(maxChars: Int) {
        self.maxChars = maxChars
    }
    
    // MARK - Public
    
    func isStringValid(_ text: String) -> Bool {
        if text.length > maxChars {
            return false
        } else {
            return true
        }
    }
}

final class MinNumberValidationRule: StringValidatable {
    
    // MARK: - Vars
    
    let minChars: Int
    let trimBeforeValidation: Bool
    
    // MAKR: - Initialization
    
    init(minChars: Int, trimBeforeValidation: Bool = false) {
        self.minChars = minChars
        self.trimBeforeValidation = trimBeforeValidation
    }
    
    func isStringValid(_ text: String) -> Bool {
        if trimBeforeValidation {
            let trimmedString = String.provideWithoutExtraWhitespaces(text)
            return trimmedString.length >= minChars
        } else {
            return text.length >= minChars
        }
    }
}

final class EmptyRule: StringValidatable {
    func isStringValid(_ text: String) -> Bool {
        return !text.isEmpty
    }
}

final class Validator {
    
    // MARK: - Vars
    
    let rule: StringValidatable
    let errorText: String
    
    // MARK: Initialization
    
    init(rule: StringValidatable, errorText: String) {
        self.rule = rule
        self.errorText = errorText
    }
    
    func isStringValid(text: String) -> Bool {
        return rule.isStringValid(text)
    }
    
    func validationErrorForText(text: String) -> String? {
        if rule.isStringValid(text) {
            return nil
        } else {
            return errorText
        }
    }
}

struct ValidationError {
    static let emptyEmail = "login_scene_empty_email_error".localized
    static let invalidEmail = "login_scene_invalid_email_error".localized
    static let minPassword = "login_scene_min_char_password_error".localized
    static let maxPassword = "login_scene_max_char_password_error".localized
    static let maxName = "login_scene_max_char_name_error".localized
    static let confirmPassword = "login_scene_confirm_password_error".localized
    static let minName = "login_scene_min_char_name_error".localized
    static let emptyName = "login_scene_empty_name_error".localized
}

struct FormValidators {
    struct Email {
        static let emailValidator = Validator(rule: EmailValidationRule(),
                                              errorText: ValidationError.invalidEmail)
        static let emptyEmailValidator = Validator(rule: EmptyRule(),
                                                   errorText: ValidationError.emptyEmail)
    }
    
    struct Password {
        static let passwordMinValidator = Validator(rule: MinNumberValidationRule(minChars: PasswordValidationRules.minPassword),
                                                    errorText: ValidationError.minPassword)
        static let passwordMaxValidator = Validator(rule: MaxNumberValidationRule(maxChars: PasswordValidationRules.maxPassowrd),
                                                    errorText: ValidationError.maxPassword)
        
    }
    
    struct Name {
        static let nameMaxValidator = Validator(rule: MaxNumberValidationRule(maxChars: PasswordValidationRules.maxName),
                                                errorText: ValidationError.maxName)
        static let nameMinValidator = Validator(rule: MinNumberValidationRule(minChars: PasswordValidationRules.minName, trimBeforeValidation: true), errorText: ValidationError.minName)
        static let emptyNameValidator = Validator(rule: EmptyRule(),
                                                  errorText: ValidationError.emptyName)
    }
    
    static let nameValidators = [Name.emptyNameValidator, Name.nameMinValidator, Name.nameMaxValidator]
    static let emailValidators = [Email.emptyEmailValidator, Email.emailValidator]
    static let passwordValidators = [Password.passwordMinValidator, Password.passwordMaxValidator]
}


