//
//  FilterData.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 20/05/2024.
//

import Foundation

protocol Filter {
    associatedtype T
    var value: String { get }
    var keyPath: PartialKeyPath<T> { get }
}

enum GameFilter: Filter {
    case acquisitionYear(String)
    case gameCondition(String)
    case gameCompleteness(String)
    case gameRegion(String)
    case storageArea(String)
//    case rating(String)
    
    var value: String {
        switch self {
        case .acquisitionYear(let value), .gameCondition(let value), .gameCompleteness(let value), .gameRegion(let value), .storageArea(let value):
            return value
//        case .rating(_):
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
        }
    }
}
