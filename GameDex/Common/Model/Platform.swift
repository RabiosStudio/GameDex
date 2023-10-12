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
    let games: [SavedGame]?
}

extension Platform: Equatable {
    public static func == (lhs: Platform, rhs: Platform) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.games == rhs.games
    }
}
