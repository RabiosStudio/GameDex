//
//  LocalDatabase.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 15/09/2023.
//

import Foundation

// sourcery: AutoMockable
protocol LocalDatabase {
    func add(newEntity: SavedGame, platform: Platform) async -> DatabaseError?
    func add(storageArea: String) async -> DatabaseError?
    func getPlatform(platformId: Int) -> Result<PlatformCollected?, DatabaseError>
    func get(storageArea: String) -> Result<StorageArea?, DatabaseError>
    func getGamesStoredIn(storageArea: String) async -> Result<[GameCollected], DatabaseError> 
    func fetchAllPlatforms() -> Result<[PlatformCollected], DatabaseError>
    func fetchAllStorageAreas() -> Result<[String], DatabaseError>
    func replace(savedGame: SavedGame) async -> DatabaseError?
    func replaceStorageArea(oldValue: String, newValue: String) async -> DatabaseError?
    func remove(savedGame: SavedGame) async -> DatabaseError?
    func remove(platform: Platform) async -> DatabaseError?
    func remove(storageArea: String) async -> DatabaseError?
    func removeAll() async -> DatabaseError?
}
