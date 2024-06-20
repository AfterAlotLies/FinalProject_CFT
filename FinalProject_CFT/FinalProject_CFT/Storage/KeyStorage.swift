//
//  KeyStorage.swift
//  FinalProject_CFT
//
//  Created by Vyacheslav on 18.06.2024.
//

import Foundation
import Security

protocol IKeyStorage {
    func saveToken(token: String)
    func getToken() -> String?
    func deleteToken()
}

class KeyStorage: IKeyStorage {
    
    static let shared = KeyStorage()
    
    private init() {}
    
    var username: String? {
        return UserDefaults.standard.string(forKey: "username")
    }
    
    func saveUsername(username: String) {
        UserDefaults.standard.setValue(username, forKey: "username")
    }
    
    func deleteSavedUsername() {
        UserDefaults.standard.removeObject(forKey: "username")
    }
    
    func saveToken(token: String) {
        guard let data = token.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecValueData as String: data
        ]
        
        SecItemDelete(query as CFDictionary)
        
        let status = SecItemAdd(query as CFDictionary, nil)
        
        if status != errSecSuccess {
            print("error saving token: \(status)")
        }
    }
    
    func getToken() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var dataTypeRef: AnyObject?
        
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        guard status == errSecSuccess, let data = dataTypeRef as? Data else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func deleteToken() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        
        if status != errSecSuccess {
            print("error deleting token: \(status)")
        }
    }
}
