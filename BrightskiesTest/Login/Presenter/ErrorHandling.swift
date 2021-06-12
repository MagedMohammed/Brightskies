//
//  ErrorHandling.swift
//  BrightskiesTest
//
//  Created by Maged Omar on 12/06/2021.
//

import Foundation

enum ValidationError: LocalizedError {
    case invalidLogin
    case incorrectEmailFormat
    case emailIsEmpty
    case passwordIsEmpty
    case passwordTooShort
    
    var errorDescription: String? {
        switch self {
        case .invalidLogin:
            return "Incorrect username or password. Please try again."
        case .incorrectEmailFormat:
            return "Please Enter Correct Email."
        case .passwordTooShort:
            return "Your password is too short."
        case .emailIsEmpty:
            return "Please Enter Your Email."
        case .passwordIsEmpty:
            return "Please Enter Your Password"
        }
    }
}

struct ValidationService {
    //    MARK:- Method
    func emailValidationError(_ email: String?) -> ValidationError? {
        guard let email = email, !email.isEmpty else {
            return ValidationError.emailIsEmpty
        }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if !emailPred.evaluate(with: email) {
            return ValidationError.incorrectEmailFormat
        }
        
        if let emailName = email.split(separator: "@").first , emailName.count < 3 {
            return ValidationError.incorrectEmailFormat
            
        }
        return nil
    }
    
    func passwordValidationError(_ password:String? ) -> ValidationError?{
        guard let password = password, !password.isEmpty else {
            return ValidationError.passwordIsEmpty
        }
        
        if password.count < 8 {
            return ValidationError.passwordTooShort
        }
        return nil
    }
}
