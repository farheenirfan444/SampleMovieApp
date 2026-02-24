//
//  EmailChecker.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 20/02/2026.
//

import Foundation
extension String {
var isValidEmail: Bool {
    let emailRegEx = "^[A-Z0-9a-z]+@[A-Za-z]+\\.[A-Za-z]{2,64}$"
    let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return email.evaluate(with: self)
 }
}
