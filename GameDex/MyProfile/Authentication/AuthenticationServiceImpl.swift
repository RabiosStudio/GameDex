//
//  AuthenticationServiceImpl.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation
import FirebaseAuth

class AuthenticationServiceImpl: AuthenticationService {
    let authSession: AuthSession
    
    init(authSession: AuthSession = Auth.auth()) {
        self.authSession = authSession
    }
    
    func login(email: String, password: String, cloudDatabase: CloudDatabase, localDatabase: LocalDatabase) async -> AuthenticationError? {
        let email = email.lowercased()
        guard await authSession.logIn(email: email, password: password) == nil,
              let userId = self.getUserId() else {
            return AuthenticationError.loginError
        }
        guard await cloudDatabase.syncLocalAndCloudDatabases(userId: userId, localDatabase: localDatabase) == nil else {
            return AuthenticationError.saveUserDataError
        }
        return nil
    }
    
    func createUser(email: String, password: String, cloudDatabase: CloudDatabase) async -> AuthenticationError? {
        let email = email.lowercased()
        guard await authSession.createUser(email: email, password: password) == nil,
              let userId = self.getUserId() else {
            return AuthenticationError.createAccountError
        }
        guard await cloudDatabase.saveUser(userId: userId, userEmail: email) == nil else {
            return AuthenticationError.saveUserDataError
        }
        return nil
    }
    
    func logout() async -> AuthenticationError? {
        guard let error = authSession.logOut() else {
            return nil
        }
        return error
    }
    
    func isUserLoggedIn() -> Bool {
        return authSession.getUserUid() != nil
    }
    
    func getUserId() -> String? {
        return authSession.getUserUid()
    }
    
    func updateUserEmailAddress(to newEmail: String, cloudDatabase: CloudDatabase) async -> AuthenticationError? {
        guard await self.authSession.updateUserEmailAddress(to: newEmail) == nil else {
            return AuthenticationError.saveUserDataError
        }
        guard let userId = getUserId(),
              await cloudDatabase.saveUserEmail(userId: userId, userEmail: newEmail) == nil else {
            return nil
        }
        return nil
    }
    
    func updateUserPassword(to newPassword: String) async -> AuthenticationError? {
        guard await self.authSession.updateUserPassword(to: newPassword) == nil else {
            return AuthenticationError.saveUserDataError
        }
        return nil
    }
    
    func reauthenticateUser(email: String, password: String) async -> AuthenticationError? {
        guard await self.authSession.reauthenticate(email: email, password: password) == nil else {
            return AuthenticationError.loginError
        }
        return nil
    }
    
    func deleteUser(cloudDatabase: CloudDatabase) async -> AuthenticationError? {
        guard let userId = self.getUserId(),
              await self.authSession.deleteUser() == nil else {
            return AuthenticationError.deleteUserError
        }
        guard await cloudDatabase.removeUser(userId: userId) == nil else {
            return nil
        }
        return nil
    }
    
    func sendPasswordResetEmail(userEmail: String) async -> AuthenticationError? {
        guard let error = await self.authSession.sendPasswordResetEmail(email: userEmail) else {
            return nil
        }
        return error
    }
}
