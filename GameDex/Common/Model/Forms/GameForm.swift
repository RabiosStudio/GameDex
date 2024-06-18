//
//  GameForm.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 31/05/2024.
//

import Foundation

struct GameForm: Equatable {
    var isPhysical: Bool
    var acquisitionYear: String?
    var gameCondition: GameCondition?
    var gameCompleteness: GameCompleteness?
    var gameRegion: GameRegion?
    var storageArea: String?
    var rating: Int
    var notes: String?
}
