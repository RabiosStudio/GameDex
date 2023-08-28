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
    
    var errorTitle: String {
        switch self {
        case .noItems:
            return L10n.emptyItemsTitle
        case .server:
            return L10n.apiErrorTitle
        }
    }
    
    var errorDescription: String {
        switch self {
        case .noItems:
            return L10n.emptyItemsDescription
        case .server:
            return L10n.apiErrorDescription
        }
    }
    
    var imageName: String {
        switch self {
        case .noItems:
            return Asset.noItems.name
        case .server:
            return Asset.exclamationMark.name
        }
        
    }
    
    var buttonTitle: String {
        switch self {
        case .noItems:
            return ""
        case .server:
            return L10n.retry
        }
    }
    
    var errorAction: ErrorAction {
        switch self {
        case .noItems:
            return .refresh
        case .server:
            return .refresh
        }
    }
}
