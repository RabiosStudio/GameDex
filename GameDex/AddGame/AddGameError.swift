//
//  AddGameError.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 26/08/2023.
//

import Foundation

enum AddGameError: EmptyError {
    case noItems
    case server
    case noSearch(platformName: String)
    
    var errorTitle: String? {
        switch self {
        case .noItems:
            return L10n.emptyItemsTitle
        case .server:
            return L10n.apiErrorTitle
        case .noSearch(let platformName):
            return L10n.emptyGameSearch + " " + platformName
        }
    }
    
    var errorDescription: String? {
        switch self {
        case .noItems:
            return L10n.emptyItemsDescription
        case .server:
            return L10n.apiErrorDescription
        case .noSearch:
            return nil
        }
    }
    
    var imageName: String? {
        switch self {
        case .noItems:
            return Asset.noItems.name
        case .server:
            return Asset.exclamationMark.name
        case .noSearch:
            return Asset.jumelles.name
        }
        
    }
    
    var buttonTitle: String? {
        switch self {
        case .noItems:
            return nil
        case .server:
            return L10n.retry
        case .noSearch:
            return nil
        }
    }
    
    var errorAction: ErrorAction? {
        switch self {
        case .noItems:
            return nil
        case .server:
            return .refresh
        case .noSearch:
            return nil
        }
    }
}
