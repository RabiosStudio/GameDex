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
        case (.present(controller: _, screenSize: _, completionBlock: _), .present(controller: _, screenSize: _, completionBlock: _)):
            return true
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
