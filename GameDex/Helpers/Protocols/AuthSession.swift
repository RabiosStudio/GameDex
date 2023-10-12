//
//  AuthSession.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 12/10/2023.
//

import Foundation
import FirebaseAuth

protocol AuthSession {
    func logIn(email: String, password: String) async -> AuthenticationError?
    func createUser(email: String, password: String) async -> AuthenticationError?
    func logOut() -> AuthenticationError?
    func getUserUid() -> String?
}

extension Auth: AuthSession {
    func logIn(email: String, password: String) async -> AuthenticationError? {
        do {
            try await Auth.auth().signIn(withEmail: email, password: password)
            return nil
        } catch {
            return AuthenticationError.loginError
        }
    }
    
    func createUser(email: String, password: String) async -> AuthenticationError? {
        do {
            try await Auth.auth().createUser(withEmail: email, password: password)
            return nil
        } catch {
            return AuthenticationError.createAccountError
        }
    }
    
    func logOut() -> AuthenticationError? {
        do {
            try Auth.auth().signOut()
            return nil
        } catch {
            return AuthenticationError.logoutError
        }
    }
    
    func getUserUid() -> String? {
        return Auth.auth().currentUser?.uid
    }
}
