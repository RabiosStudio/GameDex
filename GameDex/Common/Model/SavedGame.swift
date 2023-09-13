//
//  OwnedGame.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 10/09/2023.
//

import Foundation

struct SavedGame {
    var game: Game
    var acquisitionYear: String?
    var gameCondition: String?
    var gameCompleteness: String?
    var gameRegion: String?
    var storageArea: String?
    var rating: Int?
    var notes: String?
    
    init(game: Game,
         acquisitionYear: String?,
         gameCondition: String?,
         gameCompleteness: String?,
         gameRegion: String?,
         storageArea: String?,
         rating: Int?,
         notes: String?
    ) {
        self.game = game
        self.acquisitionYear = acquisitionYear
        self.gameCondition = gameCondition
        self.gameCompleteness = gameCompleteness
        self.gameRegion = gameRegion
        self.storageArea = storageArea
        self.rating = rating
        self.notes = notes
    }
}
