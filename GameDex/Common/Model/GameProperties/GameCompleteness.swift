//
//  Completeness.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 06/09/2023.
//

import Foundation

enum GameCompleteness: String, CaseIterable {
    case complete
    case noNotice
    case loose
    case sealed
    case unknown
    
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
        case .unknown:
            return L10n.unknown
        }
    }
    
    static func getRawValue(value: String) -> Self {
        switch value {
        case L10n.complete:
            return .complete
        case L10n.noNotice:
            return .noNotice
        case L10n.loose:
            return .loose
        case L10n.sealed:
            return .sealed
        default:
            return .unknown
        }
    }
}
