//
//  GameFilter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/05/2024.
//

import Foundation

enum GameFilter: Filter, Equatable {
    case isPhysical(Bool)
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
        case let .isPhysical(value):
            return Bool(value) as? T
        }
    }
    
    var keyPath: PartialKeyPath<SavedGame> {
        switch self {
        case .acquisitionYear:
            return \SavedGame.acquisitionYear
        case .gameCondition:
            return \SavedGame.gameCondition?.rawValue
        case .gameCompleteness:
            return \SavedGame.gameCompleteness?.rawValue
        case .gameRegion:
            return \SavedGame.gameRegion?.rawValue
        case .storageArea:
            return \SavedGame.storageArea
        case .rating:
            return \SavedGame.rating
        case .isPhysical:
            return \SavedGame.isPhysical
        }
    }
}
