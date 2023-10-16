//
//  Game.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 29/08/2023.
//

import Foundation

struct Game: Codable {
    let title: String
    let description: String
    let id: String
    let platformId: Int
    let imageUrl: String
    let releaseDate: Date?
}

extension Game: Equatable {
    public static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.description == rhs.description &&
        lhs.releaseDate == rhs.releaseDate &&
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.imageUrl == rhs.imageUrl &&
        lhs.platformId == rhs.platformId
    }
}
