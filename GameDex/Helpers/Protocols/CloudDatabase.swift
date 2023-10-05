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
    func saveUser(userEmail: String) async -> DatabaseError?
    func saveGame(userEmail: String, platform: Platform, localDatabase: LocalDatabase) async -> DatabaseError?
    func saveCollection(userEmail: String, localDatabase: LocalDatabase) async -> DatabaseError?
    func getApiKey() async -> Result<String, DatabaseError>
}
