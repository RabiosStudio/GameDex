//
//  Equatables.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation
@testable import GameDex

extension AddGameError: Equatable {
    public static func == (lhs: AddGameError, rhs: AddGameError) -> Bool {
        lhs.errorTitle == rhs.errorTitle &&
        lhs.imageName == rhs.imageName &&
        lhs.errorDescription == rhs.errorDescription &&
        lhs.errorAction == rhs.errorAction &&
        lhs.buttonTitle == rhs.buttonTitle
    }
}

extension ErrorAction: Equatable {
    public static func == (lhs: GameDex.ErrorAction, rhs: GameDex.ErrorAction) -> Bool {
        switch (lhs, rhs) {
        case (.refresh, .refresh):
            return true
        case (.navigate(style: _), .navigate(style: _)):
            return true
        default:
            return false
        }
    }
}

extension MyCollectionError: Equatable {
    public static func == (lhs: MyCollectionError, rhs: MyCollectionError) -> Bool {
        lhs.errorTitle == rhs.errorTitle &&
        lhs.imageName == rhs.imageName &&
        lhs.errorDescription == rhs.errorDescription &&
        lhs.errorAction == rhs.errorAction &&
        lhs.buttonTitle == rhs.buttonTitle
    }
}

extension NavigationStyle: Equatable {
    public static func == (lhs: GameDex.NavigationStyle, rhs: GameDex.NavigationStyle) -> Bool {
        switch (lhs, rhs) {
        case let (.push(screenFactory1), .push(screenFactory2)):
            return type(of: screenFactory1) == type(of: screenFactory2)
        case (.pop, .pop):
            return true
        case let (.present(screenFactory1, screenSize: _, completionBlock: _), .present(screenFactory2, screenSize: _, completionBlock: _)):
            return type(of: screenFactory1) == type(of: screenFactory2)
        case (.dismiss, .dismiss):
            return true
        case (.selectTab, .selectTab):
            return true
        default:
            return false
        }
    }
}

extension AlertViewModel: Equatable {
    public static func == (lhs: AlertViewModel, rhs: AlertViewModel) -> Bool {
        lhs.alertType == rhs.alertType &&
        lhs.cancelButtonTitle == rhs.cancelButtonTitle &&
        lhs.description == rhs.description &&
        lhs.okButtonTitle == rhs.okButtonTitle
    }
}

extension Platform: Equatable {
    public static func == (lhs: Platform, rhs: Platform) -> Bool {
        lhs.id == rhs.id &&
        lhs.title == rhs.title &&
        lhs.games == rhs.games
    }
}

extension SavedGame: Equatable {
    public static func == (lhs: SavedGame, rhs: SavedGame) -> Bool {
        lhs.acquisitionYear == rhs.acquisitionYear &&
        lhs.gameCompleteness == rhs.gameCompleteness &&
        lhs.gameCondition == rhs.gameCondition &&
        lhs.gameRegion == rhs.gameRegion &&
        lhs.lastUpdated == rhs.lastUpdated &&
        lhs.notes == rhs.notes &&
        lhs.rating == rhs.rating &&
        lhs.storageArea == rhs.storageArea &&
        lhs.game == rhs.game
    }
}

extension Game: Equatable {
    public static func == (lhs: Game, rhs: Game) -> Bool {
        lhs.title == rhs.title &&
        lhs.id == rhs.id &&
        lhs.description == rhs.description &&
        lhs.imageURL == rhs.imageURL &&
        lhs.platformId == rhs.platformId &&
        lhs.releaseDate == rhs.releaseDate
    }
}
