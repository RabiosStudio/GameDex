//
//  SavedData.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 10/09/2023.
//

import Foundation

public enum DatabaseKey: String, Codable {
    case savedGame = "Saved Game"
}

public protocol SavedData: Codable {
    var databaseKey: DatabaseKey { get }
    var id: UUID { get set }
}
