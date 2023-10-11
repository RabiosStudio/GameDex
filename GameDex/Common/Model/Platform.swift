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
        let zip = zip(lhs.games!, rhs.games!).map { $0.0 == $0.1 }
        let newArray = Array(zip)
        if newArray.contains(false) {
            return false
        } else {
            return lhs.id == rhs.id && lhs.title == rhs.title
        }
    }
}
