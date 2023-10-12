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
    func getPlatform(platformId: Int) -> Result<PlatformCollected?, DatabaseError>
    func fetchAllPlatforms() -> Result<[PlatformCollected], DatabaseError>
    func replace(savedGame: SavedGame) async -> DatabaseError?
    func remove(savedGame: SavedGame) async -> DatabaseError?
    func removeAll() async -> DatabaseError?
}
