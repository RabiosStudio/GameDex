//
//  MyCollectionError.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

enum MyCollectionError: EmptyError {
    
    case noItems
    
    var errorTitle: String {
        switch self {
        case .noItems:
            return L10n.emptyCollectionTitle
        }
    }
    
    var errorDescription: String {
        switch self {
        case .noItems:
            return L10n.emptyCollectionDescription
        }
    }
    
    var imageName: String {
        return Asset.ghost.name
    }
    
    var buttonTitle: String {
        switch self {
        case .noItems:
            return L10n.addGameButtonTitle
        }
    }
    
    var errorAction: ErrorAction {
        switch self {
        case .noItems:
            let addGameController = AddGameStepOneScreenFactory().viewController
            let startToAddGame: NavigationStyle = .present(
                controller: addGameController,
                completionBlock: nil)
            return .navigate(style: startToAddGame)
        }
    }
}
