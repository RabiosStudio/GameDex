//
//  GameFilter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/05/2024.
//

import Foundation

enum GameFilter: Filter {
    case acquisitionYear(String)
    case gameCondition(GameCondition.RawValue)
    case gameCompleteness(GameCompleteness.RawValue)
    case gameRegion(GameRegion.RawValue)
    case storageArea(String)
    case rating(Int)
    
    func value<T>() -> T? {
        switch self {
        case .acquisitionYear(let value), .gameCondition(let value), .gameCompleteness(let value), .gameRegion(let value), .storageArea(let value):
            return String(value) as? T
        case .rating(let value):
            return Int(value) as? T
        }
    }
    
    var keyPath: PartialKeyPath<SavedGame> {
        switch self {
        case .acquisitionYear(_):
            return \SavedGame.acquisitionYear
        case .gameCondition(_):
            return \SavedGame.gameCondition
        case .gameCompleteness(_):
            return \SavedGame.gameCompleteness
        case .gameRegion(_):
            return \SavedGame.gameRegion
        case .storageArea(_):
            return \SavedGame.storageArea
        case .rating(_):
            return \SavedGame.rating
        }
    }
}
