//
//  GameFilterForm.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 06/06/2024.
//

import Foundation

struct GameFilterForm: Equatable {
    var isPhysical: Bool?
    var acquisitionYear: String?
    var gameCondition: GameCondition?
    var gameCompleteness: GameCompleteness?
    var gameRegion: GameRegion?
    var storageArea: String?
    var rating: Int?
}
