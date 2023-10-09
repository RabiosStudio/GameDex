//
//  CloudDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 02/10/2023.
//

import Foundation

// sourcery: AutoMockable
protocol CloudDatabase {
    func getAvailablePlatforms() async -> Result<[Platform], DatabaseError>
    func saveUser(userId: String, userEmail: String) async -> DatabaseError?
    func saveGame(userId: String, platform: Platform) async -> DatabaseError?
    func saveCollection(userId: String, localDatabase: LocalDatabase) async -> DatabaseError? 
    func getApiKey() async -> Result<String, DatabaseError>
}
