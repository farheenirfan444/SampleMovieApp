//
//  UserViewModel.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 20/02/2026.
//

import Foundation
import UIKit
internal import CoreData

final class UserViewModel{
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    func createUser(email: String, name: String, phone: String, city: String) {
        let user = User(context: context)
        user.email = email
        user.name = name
        user.phoneNumber = phone
        user.city = city
        user.createdAt = .now
        user.updatedAt = .now
        user.id = UUID()
        do {
            try context.save()
        }
        catch {
            print("Error while creating a user", error.localizedDescription)
        }
    }

    func fetchUser() {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            let users = try context.fetch(request)
            print(users)
        } catch {
            print("Error while fetching users", error.localizedDescription)
        }
    }

    func findUser(byEmail email: String) -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        request.predicate = NSPredicate(format: "email == %@", email)
        do {
            let users = try context.fetch(request)
            return users.first
        } catch {
            print("Error while fetching users", error.localizedDescription)
            return nil
        }
    }

    func emailExists(email: String) -> Bool {
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "email == %@", email)
        
        do {
            let result = try context.fetch(fetchRequest)
            return !result.isEmpty
        }
        catch {
            print("Error while checking email", error)
            return false
        }
        
    }

}





