//
//  Keychain.swift
//  Dofamin
//
//  Created by Nodira Shukurova on 31/01/25.
//

import Foundation
import KeychainSwift

struct TokenStorage {
    static let token = "tj.dofamin.token"
    static let user = "tj.dofamin.user"
}

class KeychainManager {
    static let shared = KeychainManager()
    
    private init() {}
    
    private let keychain = KeychainSwift()
    private let defaults = UserDefaults.standard
    
    var isAuthenticated: Bool {
        token != nil
    }
    
    var isIdentified: Bool {
        user != nil
    }
    
    var user: User? {
        get {
            guard let savedData = defaults.data(forKey: TokenStorage.user),
                  let decodedUser = try? JSONDecoder().decode(User.self, from: savedData) else {
                return nil
            }
            return decodedUser
        }
        set {
            if let newUser = newValue,
               let encoded = try? JSONEncoder().encode(newUser) {
                defaults.set(encoded, forKey: TokenStorage.user)
            } else {
                defaults.removeObject(forKey: TokenStorage.user)
            }
        }
    }
    
    var token: String? {
        get {
            keychain.get(TokenStorage.token)
        }
        set {
            if let newToken = newValue {
                keychain.set(newToken, forKey: TokenStorage.token)
            } else {
                keychain.delete(TokenStorage.token)
            }
        }
    }
    
    func clear() {
        defaults.removeObject(forKey: TokenStorage.user)
        keychain.clear()
    }
}

struct User: Codable {
    let fullName: String
    let phoneNumber: String
    let id: Int
    var avatar: String?
    
    init(response: UserResponse) {
        self.fullName = response.fullName
        self.phoneNumber = response.phoneNumber
        self.id = response.id
        self.avatar = response.imageUrl
    }
}
