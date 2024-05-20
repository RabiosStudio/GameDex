//
//  Platform.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

struct Platform {
    let title: String
    let id: Int
    let imageUrl: String
    let games: [SavedGame]?
    let supportedNames: [String]
}

extension Platform: Equatable {
    public static func == (lhs: Platform, rhs: Platform) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.imageUrl == rhs.imageUrl &&
        lhs.games == rhs.games
    }
}
