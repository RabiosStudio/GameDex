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
}
