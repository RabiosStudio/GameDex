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

extension SavedGame: Equatable {
    public static func == (lhs: SavedGame, rhs: SavedGame) -> Bool {
        lhs.acquisitionYear == rhs.acquisitionYear &&
        lhs.game == rhs.game &&
        lhs.gameCompleteness == rhs.gameCompleteness &&
        lhs.gameCondition == rhs.gameCondition &&
        lhs.gameRegion == rhs.gameRegion &&
        lhs.lastUpdated == rhs.lastUpdated &&
        lhs.notes == rhs.notes &&
        lhs.rating == rhs.rating &&
        lhs.storageArea == rhs.storageArea
    }
}
