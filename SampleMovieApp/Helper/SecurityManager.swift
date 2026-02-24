//
//  SecurityManager.swift
//  SampleMovieApp
//
//  Created by Faheem Irfan on 21/02/2026.
//

import Foundation
import Security

class SecurityManager {
    
static func savePassword(password: String, account: String) {
    let data = Data(password.utf8)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: account,
            kSecValueData as String: data
    ]
        
    SecItemDelete(query as CFDictionary)
    let status = SecItemAdd(query as CFDictionary, nil)
        
    if status == errSecSuccess {
        print("Password saved successfully in Keychain")
        
        } else {
            print("Error saving password: \(status)")
        }
    }
    
static func getPassword(account: String) -> String? {
    let query: [String: Any] = [
        kSecClass as String: kSecClassGenericPassword,
        kSecAttrAccount as String: account,
        kSecReturnData as String: kCFBooleanTrue!,
        kSecMatchLimit as String: kSecMatchLimitOne
    ]
    var dataTypeRef: AnyObject?
    let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
    if status == errSecSuccess, let data = dataTypeRef as? Data {
        return String(data: data, encoding: .utf8)
    }
        return nil
    }
}
