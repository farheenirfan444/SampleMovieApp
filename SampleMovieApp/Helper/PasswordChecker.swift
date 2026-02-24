//
//  PasswordChecker.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 20/02/2026.
//

import Foundation


extension String {
var isValidPassword : Bool {
    let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[@#$%]).{6,}$"
    let passwordTest = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
    return passwordTest.evaluate(with: self)
 }
}

