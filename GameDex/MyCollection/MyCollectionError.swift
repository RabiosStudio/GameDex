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
            return L10n.emptyMyCollectionTitle
        }
    }
    
    var errorDescription: String {
        switch self {
        case .noItems:
            return L10n.emptyMyCollectionDescription
        }
    }
    
    var imageName: String {
        return Asset.ghost4.name
    }
    
    var buttonTitle: String {
        switch self {
        case .noItems:
            return L10n.addGame
        }
    }
    
    var errorAction: ErrorAction {
        switch self {
        case .noItems:
            let addGameController = AddBasicGameInformationScreenFactory().viewController
            let startToAddGame: NavigationStyle = .present(
                controller: addGameController,
                completionBlock: nil)
            return .navigate(style: startToAddGame)
        }
    }
}
