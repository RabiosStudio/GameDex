//
//  Database.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 15/09/2023.
//

import Foundation

// sourcery: AutoMockable
protocol Database {
    func add(newEntity: SavedGame, platform: Platform, callback: @escaping (DatabaseError?) -> ())
    func getPlatform(platformId: Int) -> Result<PlatformCollected?, DatabaseError>
    func fetchAllPlatforms() -> Result<[PlatformCollected], DatabaseError>
    func replace(savedGame: SavedGame, callback: @escaping (DatabaseError?) -> ())
    func remove(savedGame: SavedGame, callback: @escaping (DatabaseError?) -> ())
}
