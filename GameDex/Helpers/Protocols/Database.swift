//
//  Database.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 11/09/2023.
//

import Foundation

protocol Database {
    static func fetchAll<T: SavedData>(databaseKey: DatabaseKey) -> Result<[T], DatabaseError>
    static func add<T: SavedData>(newEntity: T) -> Result<String, DatabaseError>
    static func replace<T: SavedData>(newEntity: T) -> Result<String, DatabaseError>
}
