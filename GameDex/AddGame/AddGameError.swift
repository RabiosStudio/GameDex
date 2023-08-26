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
            return "Could not find any items"
        case .server:
            return "Oops!"
        }
    }
    
    var errorDescription: String {
        switch self {
        case .noItems:
            return "There are no items available for your selected options"
        case .server:
            return "There has been an issue while fetching data"
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
            return "Retry"
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
