//
//  MyCollectionError.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

enum MyCollectionError: EmptyError {
    
    case emptyCollection(myCollectionDelegate: MyCollectionViewModelDelegate?)
    case fetchError
    case noItems(myCollectionDelegate: MyCollectionViewModelDelegate?)
    
    var errorTitle: String? {
        switch self {
        case .emptyCollection:
            return L10n.emptyMyCollectionTitle
        case .fetchError:
            return L10n.fetchGamesErrorDescription
        case .noItems:
            return L10n.emptyItemsTitle
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .emptyCollection:
            return L10n.emptyMyCollectionDescription
        case .fetchError:
            return L10n.warningTryAgain
        case .noItems:
            return nil
        }
    }
    
    var imageName: String? {
        switch self {
        case .emptyCollection:
            return Asset.ghost8.name
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
            return L10n.clearSearch
        }
    }
    
    var errorAction: ErrorAction? {
        switch self {
        case .emptyCollection(myCollectionDelegate: let delegate):
            let startToAddGame: NavigationStyle = .present(
                screenFactory: SelectPlatformScreenFactory(
                    delegate: delegate
                ),
                completionBlock: nil)
            return .navigate(style: startToAddGame)
        case .fetchError:
            return .refresh
        case .noItems(myCollectionDelegate: let delegate):
            Task {
                await delegate?.clearFilters()
            }
            return nil
        }
    }
}
