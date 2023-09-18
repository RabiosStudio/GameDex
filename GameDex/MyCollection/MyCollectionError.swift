//
//  MyCollectionError.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

enum MyCollectionError: EmptyError {
    
    case emptyCollection(gameDetailsDelegate: GameDetailsViewModelDelegate?)
    case fetchError
    case noItems
    
    var errorTitle: String {
        switch self {
        case .emptyCollection:
            return L10n.emptyMyCollectionTitle
        case .fetchError:
            return L10n.fetchGamesErrorDescription
        case .noItems:
            return L10n.emptyItemsTitle
        }
    }
    
    var errorDescription: String {
        switch self {
        case .emptyCollection:
            return L10n.emptyMyCollectionDescription
        case .fetchError:
            return L10n.warningTryAgain
        case .noItems:
            return L10n.emptyItemsDescription
        }
    }
    
    var imageName: String {
        switch self {
        case .emptyCollection:
            return Asset.noItems.name
        case .fetchError:
            return Asset.exclamationMark.name
        case .noItems:
            return Asset.noItems.name
        }
    }
    
    var buttonTitle: String? {
        switch self {
        case .emptyCollection:
            return L10n.addAGame
        case .fetchError:
            return L10n.refresh
        case .noItems:
            return nil
        }
    }
    
    var errorAction: ErrorAction {
        switch self {
        case .emptyCollection(gameDetailsDelegate: let delegate):
            let selectAddGameTypeController = SelectAddGameMethodScreenFactory(
                delegate: delegate
            ).viewController
            let startToAddGame: NavigationStyle = .present(
                controller: selectAddGameTypeController,
                completionBlock: nil)
            return .navigate(style: startToAddGame)
        case .fetchError:
            return .refresh
        case .noItems:
            return .refresh
        }
    }
}
