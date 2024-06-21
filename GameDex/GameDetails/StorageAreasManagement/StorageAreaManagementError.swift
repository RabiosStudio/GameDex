//
//  StorageAreaManagementError.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 21/06/2024.
//

import Foundation

enum StorageAreaManagementError: EmptyError {
    
    case emptyStorageAreas(delegate: StorageAreasManagementDelegate?)
    case fetchError
    
    var errorTitle: String? {
        switch self {
        case .emptyStorageAreas:
            return L10n.emptyStorageAreasTitle
        case .fetchError:
            return nil
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .emptyStorageAreas:
            return nil
        case .fetchError:
            return L10n.fetchStorageAreaErrorTitle
        }
    }
    
    var imageName: String? {
        switch self {
        case .emptyStorageAreas:
            return Asset.ghost8.name
        case .fetchError:
            return Asset.exclamationMark.name
        }
    }
    
    var buttonTitle: String? {
        switch self {
        case .emptyStorageAreas:
            return L10n.addAStorageArea
        case .fetchError:
            return L10n.refresh
        }
    }
    
    var errorAction: ErrorAction? {
        switch self {
        case let .emptyStorageAreas(delegate):
            delegate?.addNewEntity()
            return nil
        case .fetchError:
            return .refresh
        }
    }
}
