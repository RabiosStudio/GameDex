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
    func getGameUUID(userId: String, newGame: SavedGame, oldGame: SavedGame) async -> Result<String?, DatabaseError>
    
    func saveUser(userId: String, userEmail: String) async -> DatabaseError?
    func saveUserEmail(userId: String, userEmail: String) async -> DatabaseError?
    func saveGames(userId: String, platform: Platform) async -> DatabaseError?
    func saveGame(userId: String, game: SavedGame, platform: Platform) async -> DatabaseError?
    func savePlatform(userId: String, platform: Platform) async -> DatabaseError? 
    func saveCollection(userId: String, localDatabase: LocalDatabase) async -> DatabaseError?
    
    func replaceGame(userId: String, newGame: SavedGame, oldGame: SavedGame, platform: Platform) async -> DatabaseError?
    
    func gameIsInDatabase(userId: String, savedGame: SavedGame) async -> Result<Bool, DatabaseError>
    
    func removeGame(userId: String, platform: Platform, savedGame: SavedGame) async -> DatabaseError?
    func removeUser(userId: String) async -> DatabaseError?
    func removePlatform(userId: String, platform: Platform) async -> DatabaseError? 
    func removePlatformAndGames(userId: String, platform: Platform) async -> DatabaseError?
    
    func syncLocalAndCloudDatabases(userId: String, localDatabase: LocalDatabase) async -> DatabaseError?
}
