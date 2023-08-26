//
//  EmptyError.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation

protocol EmptyError: LocalizedError {
    var errorTitle: String { get }
    var imageName: String { get }
    var buttonTitle: String { get }
    var errorAction: ErrorAction { get }
}

enum ErrorAction {
    case refresh
    case navigate(style: NavigationStyle)
}

extension EmptyError {
    var errorTitle: String {
        return ""
    }
    
    var imageName: String {
        return ""
    }
    
    var buttonTitle: String {
        return ""
    }
}
