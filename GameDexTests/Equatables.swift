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
        case (.url, .url):
            return true
        default:
            return false
        }
    }
}

extension AlertViewModel: Equatable {
    public static func == (lhs: AlertViewModel, rhs: AlertViewModel) -> Bool {
        lhs.alertType == rhs.alertType &&
        lhs.description == rhs.description
    }
}

extension ButtonViewModel: Equatable {
    public static func == (lhs: ButtonViewModel, rhs: ButtonViewModel) -> Bool {
        lhs.isEnabled == rhs.isEnabled &&
        lhs.title == rhs.title
    }
}

extension ButtonState: Equatable {
    public static func == (lhs: ButtonState, rhs: ButtonState) -> Bool {
        switch (lhs, rhs) {
        case (.loading, .loading):
            return true
        case let (.enabled(title1), .enabled(title2)):
            return title1 == title2
        case let (.disabled(title1), .disabled(title2)):
            return title1 == title2
        default:
            return false
        }
    }
}

extension AnyBarButtonItem: Equatable {
    public static func == (lhs: AnyBarButtonItem, rhs: AnyBarButtonItem) -> Bool {
        return lhs.position == lhs.position
    }
}
