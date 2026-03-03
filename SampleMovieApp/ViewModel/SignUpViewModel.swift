//
//  SignUpViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 26/02/2026.
//

import Foundation

final class SignUpViewModel {
    
    var userViewModel = UserViewModel()
    
    func signUp(email: String?, password: String?) -> Result {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty
        else {
            return Result(
                success: false,
                message: "Please fill all the fields"
            )
        }
        if userViewModel.emailExists(email: email) {
            return Result(
                success: false,
                message: "Email already exists"
            )
        }
        return Result(success: true, message: "")
    }
}
