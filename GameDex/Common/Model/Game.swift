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
    let imageURL: String
    let releaseDate: Date?
}

extension Game: Equatable {
    public static func == (lhs: Game, rhs: Game) -> Bool {
        var isSameSecond = lhs.releaseDate == rhs.releaseDate
        
        if let lhsDate = lhs.releaseDate,
           let rhsDate = rhs.releaseDate {
            isSameSecond = lhsDate.isSameSecond(date: rhsDate)
        }
        
        return lhs.description == rhs.description &&
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.imageURL == rhs.imageURL &&
        lhs.platformId == rhs.platformId &&
        isSameSecond
    }
}
