//
//  LoginViewModel.swift
//  CodingTask
//
//  Created by rashesh.bosamiya on 10/12/25.
//

import Observation
import Foundation

@Observable
class LoginViewModel {
    
    var email: String = ""
    var password: String = ""
    
    var isEmailValid: Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format:"SELF MATCHES %@", regex).evaluate(with: email)
    }
    
    var isPasswordValid: Bool {
        password.count >= 8 && password.count <= 15
    }
    
    var isFormValid: Bool {
        isEmailValid && isPasswordValid
    }
}
