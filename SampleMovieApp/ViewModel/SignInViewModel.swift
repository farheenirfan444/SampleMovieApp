//
//  SignInViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 26/02/2026.
//

import Foundation

final class SignInViewModel {
    var userViewModel = UserViewModel()
    var defaults = UserDefaults.standard
    var email: String = ""
    var password: String = ""
    
    func signIn(email: String?, password: String?) -> Result {
        guard let email = email, !email.isEmpty,
              let password = password, !password.isEmpty else {
            return Result(success: false, message: "Credentials not valid.Fill all the fields.")
        }
        
        let user = userViewModel.findUser(byEmail: email)
        if user == nil {
            return Result(success: false, message: "User does not exist.Check your username.")
         }
        
        let securePassword = SecurityManager.getPassword(account: email)
        if password == securePassword {
            let loggedInUser = LoggedInUser(
                email: user?.email ?? "" ,
                name: user?.name ?? ""
            )
            UserSessionManager.shared.save(user: loggedInUser)
        }
        
        else {
            return Result(success: false, message: "Password does not match.")
        }
        
        return Result(success: true, message: "")
    }
}
