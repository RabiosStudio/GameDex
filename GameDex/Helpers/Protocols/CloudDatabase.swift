//
//  CloudDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 02/10/2023.
//

import Foundation

// sourcery: AutoMockable
protocol CloudDatabase {
    func getApiKey() async -> Result<String, DatabaseError>
    func getSinglePlatformCollection(userId: String, platform: Platform) async -> Result<Platform, DatabaseError>
    func getUserCollection(userId: String) async -> Result<[Platform], DatabaseError>
    func getAvailablePlatforms() async -> Result<[Platform], DatabaseError>
    
    func saveUser(userId: String, userEmail: String) async -> DatabaseError?
    func saveUserEmail(userId: String, userEmail: String) async -> DatabaseError?
    func saveGames(userId: String, platform: Platform) async -> DatabaseError?
    func saveGame(userId: String, game: SavedGame, platform: Platform, editingEntry: Bool) async -> DatabaseError?
    func saveCollection(userId: String, localDatabase: LocalDatabase) async -> DatabaseError?
    
    func gameIsInDatabase(userId: String, savedGame: SavedGame) async -> Result<Bool, DatabaseError>
    
    func removeGame(userId: String, platform: Platform, savedGame: SavedGame) async -> DatabaseError?
    func syncLocalAndCloudDatabases(userId: String, localDatabase: LocalDatabase) async -> DatabaseError?
}
