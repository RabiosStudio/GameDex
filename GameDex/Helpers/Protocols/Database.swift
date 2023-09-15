//
//  Database.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 15/09/2023.
//

import Foundation

// sourcery: AutoMockable
protocol Database {
    func add(newEntity: SavedGame, callback: @escaping (DatabaseError?) -> ())
    func fetchAll() -> Result<[GameCollected], DatabaseError>
    func replace(savedGame: SavedGame, callback: @escaping (DatabaseError?) -> ())
    func remove(savedGame: SavedGame, callback: @escaping (DatabaseError?) -> ())
}
