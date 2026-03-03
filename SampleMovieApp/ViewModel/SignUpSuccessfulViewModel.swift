//
//  SignUpSuccessfulViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 26/02/2026.
//

import Foundation

final class SignUpSuccessfulViewModel{
    
    // variables
    private let email: String
    private let password: String
    var userViewModel = UserViewModel()
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
    
    func isValid(name: String?, phone: String?, city: String?) -> Result {
        guard let name = name, !name.isEmpty,
              let phone = phone, !phone.isEmpty,
              let city = city, !city.isEmpty else {
            return Result(success: false, message: "Fill all the field")
        }
        return Result(success: true, message: "")
    }
    
    func submit(name: String, phone: String, city: String) -> Result {
        let result = isValid(name: name, phone: phone, city: city)
        
        guard result.success else {
            return Result(success: false, message: "Problem while creating user.")
        }
        
        SecurityManager.savePassword(password: password, account: email)
        userViewModel.createUser(email: email, name: name, phone: phone, city: city)
        let user = LoggedInUser(email: email, name: name)
        UserSessionManager.shared.save(user: user)
        return Result(success: true, message: "")
    }
}
