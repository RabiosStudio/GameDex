//
//  Completeness.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 06/09/2023.
//

import Foundation

enum GameCompleteness: CaseIterable {
    case complete
    case noNotice
    case loose
    case sealed
    
    var value: String {
        switch self {
        case .complete:
            return L10n.complete
        case .noNotice:
            return L10n.noNotice
        case .loose:
            return L10n.loose
        case .sealed:
            return L10n.sealed
        }
    }
}
