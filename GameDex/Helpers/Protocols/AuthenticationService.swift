//
//  AuthenticationService.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation

// sourcery: AutoMockable
protocol AuthenticationService {
    func login(email: String, password: String, cloudDatabase: CloudDatabase, localDatabase: LocalDatabase) async -> AuthenticationError?
    func createUser(email: String, password: String, cloudDatabase: CloudDatabase) async -> AuthenticationError?
    func logout() async -> AuthenticationError?
    func isUserLoggedIn() -> Bool 
    func getUserId() -> String?
    func updateUserEmailAddress(to newEmail: String, cloudDatabase: CloudDatabase) async -> AuthenticationError?
    func updateUserPassword(to newPassword: String) async -> AuthenticationError?
    func reauthenticateUser(email: String, password: String) async -> AuthenticationError?
    func deleteUser(cloudDatabase: CloudDatabase) async -> AuthenticationError?
    func sendPasswordResetEmail(userEmail: String) async -> AuthenticationError? 
}
