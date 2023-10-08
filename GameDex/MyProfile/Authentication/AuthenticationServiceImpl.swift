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
    
    func createUser(email: String, password: String, cloudDatabase: CloudDatabase) async -> AuthenticationError? {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            if let error = await cloudDatabase.saveUser(
                userEmail: email) {
                return AuthenticationError.saveUserDataError
            } else {
                return nil
            }
        } catch {
            return AuthenticationError.createAccountError
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
