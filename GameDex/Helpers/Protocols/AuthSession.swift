//
//  AuthSession.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 12/10/2023.
//

import Foundation
import FirebaseAuth

// sourcery: AutoMockable
protocol AuthSession {
    func logIn(email: String, password: String) async -> AuthenticationError?
    func createUser(email: String, password: String) async -> AuthenticationError?
    func logOut() -> AuthenticationError?
    func getUserUid() -> String?
    func updateUserEmailAddress(to newEmail: String) async -> AuthenticationError?
    func updateUserPassword(to newPassword: String) async -> AuthenticationError?
    func reauthenticate(email: String, password: String) async -> AuthenticationError?
    func deleteUser() async -> AuthenticationError?
    func sendPasswordResetEmail(email: String) async -> AuthenticationError?
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
    
    func updateUserEmailAddress(to newEmail: String) async -> AuthenticationError? {
        do {
            try await Auth.auth().currentUser?.updateEmail(to: newEmail)
            return nil
        } catch {
            return AuthenticationError.saveUserDataError
        }
    }
    
    func updateUserPassword(to newPassword: String) async -> AuthenticationError? {
        do {
            try await Auth.auth().currentUser?.updatePassword(to: newPassword)
            return nil
        } catch {
            return AuthenticationError.saveUserDataError
        }
    }
    
    func reauthenticate(email: String, password: String) async -> AuthenticationError? {
        let user = Auth.auth().currentUser
        let credential = EmailAuthProvider.credential(
            withEmail: email,
            password: password
        )
        do {
            try await user?.reauthenticate(with: credential)
            return nil
        } catch {
            return AuthenticationError.loginError
        }
    }
    
    func deleteUser() async -> AuthenticationError? {
        let user = Auth.auth().currentUser
        do {
            try await user?.delete()
            return nil
        } catch {
            return AuthenticationError.deleteUserError
        }
    }
    
    func sendPasswordResetEmail(email: String) async -> AuthenticationError? {
        do {
            try await Auth.auth().sendPasswordReset(withEmail: email)
            return nil
        } catch {
            return AuthenticationError.passwordResetEmailError
        }
    }
}
