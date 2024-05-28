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
        case let .acquisitionYear(value), let .gameCondition(value), let  .gameCompleteness(value), let .gameRegion(value), let .storageArea(value):
            return String(value) as? T
        case let .rating(value):
            return Int(value) as? T
        }
    }
    
    var keyPath: PartialKeyPath<SavedGame> {
        switch self {
        case .acquisitionYear(_):
            return \SavedGame.acquisitionYear
        case .gameCondition(_):
            return \SavedGame.gameCondition?.rawValue
        case .gameCompleteness(_):
            return \SavedGame.gameCompleteness?.rawValue
        case .gameRegion(_):
            return \SavedGame.gameRegion?.rawValue
        case .storageArea(_):
            return \SavedGame.storageArea
        case .rating(_):
            return \SavedGame.rating
        }
    }
}
