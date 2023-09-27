//
//  AuthenticationServiceImpl.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation
import FirebaseAuth

class AuthenticationServiceImpl: AuthenticationService {
    func login(email: String, password: String, callback: @escaping (AuthenticationError?) -> ()) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                callback(AuthenticationError.loginError)
                return
            }
            callback(nil)
        }
    }
    
    func createUser(email: String, password: String, callback: @escaping (AuthenticationError?) -> ()) {
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            guard error == nil else {
                callback(AuthenticationError.createAccountError)
                return
            }
            callback(nil)
        }
    }
    
    func logout(callback: @escaping (AuthenticationError?) -> ()) {
        do {
            try Auth.auth().signOut()
            callback(nil)
        } catch {
            callback(AuthenticationError.logoutError)
        }
    }
    
    func isUserLoggedIn() -> Bool {
        return Auth.auth().currentUser?.uid != nil
    }
}