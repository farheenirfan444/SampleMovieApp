//
//  UserSessionManager.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 20/02/2026.
//

import Foundation

final class UserSessionManager {
    //MARK: Variables
    let defaults = UserDefaults.standard
    static let shared = UserSessionManager()
    private init() {}
    private let userKey = "logged_in_user"
    
    //MARK: functions
    
    func save(user: LoggedInUser) {
        if let data = try? JSONEncoder().encode(user) {
            defaults.set(data, forKey: userKey)
        }
    }
    
    func getUser() -> LoggedInUser? {
        guard let data = defaults.data(forKey: userKey) else {
            return nil
        }
        return try? JSONDecoder().decode(LoggedInUser.self, from: data)
    }
    func logout() {
        defaults.removeObject(forKey: userKey)
    }
    var isLoggedIn: Bool {
        getUser() != nil
    }
}
