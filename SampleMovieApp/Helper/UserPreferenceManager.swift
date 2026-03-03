//
//  UserPersistanceManager.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 28/02/2026.
//

import Foundation
internal import CoreData
import UIKit

final class UserPreferenceManager {
    
    static let shared = UserPreferenceManager()
    private init() {}
    
    private let preferenceKey = "userPreferences"
    private let defaults = UserDefaults.standard
    
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    func savePreferences(_ genres: [String]){
        defaults.set(genres, forKey: preferenceKey)
    }
    func fetchPreferences() -> [String]? {
        return defaults.stringArray(forKey: preferenceKey)
    }
}

