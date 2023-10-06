//
//  OwnedGame.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 10/09/2023.
//

import Foundation

struct SavedGame {
    let game: Game
    let acquisitionYear: String?
    let gameCondition: String?
    let gameCompleteness: String?
    let gameRegion: String?
    let storageArea: String?
    let rating: Int?
    let notes: String?
    let lastUpdated: Date
}
