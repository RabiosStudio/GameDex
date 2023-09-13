//
//  MyCollectionError.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

enum MyCollectionError: EmptyError {
    
    case noItems(addGameDelegate: AddGameDetailsViewModelDelegate?)
    case fetchError
    
    var errorTitle: String {
        switch self {
        case .noItems:
            return L10n.emptyMyCollectionTitle
        case .fetchError:
            return "Error fetching data"
        }
    }
    
    var errorDescription: String {
        switch self {
        case .noItems:
            return L10n.emptyMyCollectionDescription
        case .fetchError:
            return "Please try again later"
        }
    }
    
    var imageName: String {
        switch self {
        case .noItems:
            return Asset.noItems.name
        case .fetchError:
            return Asset.exclamationMark.name
        }
    }
    
    var buttonTitle: String {
        switch self {
        case .noItems:
            return L10n.addAGame
        case .fetchError:
            return "Refresh"
        }
    }
    
    var errorAction: ErrorAction {
        switch self {
        case .noItems(addGameDelegate: let delegate):
            let selectAddGameTypeController = SelectAddGameMethodScreenFactory(
                delegate: delegate
            ).viewController
            let startToAddGame: NavigationStyle = .present(
                controller: selectAddGameTypeController,
                completionBlock: nil)
            return .navigate(style: startToAddGame)
        case .fetchError:
            return .refresh
        }
    }
}
