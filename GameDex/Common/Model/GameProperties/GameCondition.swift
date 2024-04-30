//
//  Condition.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 06/09/2023.
//

import Foundation

enum GameCondition: String, CaseIterable {
    case mint
    case veryGood
    case good
    case acceptable
    case poor
    case unknown
 
    var value: String {
        switch self {
        case .mint:
            return L10n.mint
        case .veryGood:
            return L10n.veryGood
        case .good:
            return L10n.good
        case .acceptable:
            return L10n.acceptable
        case .poor:
            return L10n.poor
        case .unknown:
            return L10n.unknown
        }
    }
    
    static func getRawValue(value: String) -> Self {
        switch value {
        case L10n.mint:
            return .mint
        case L10n.veryGood:
            return .veryGood
        case L10n.good:
            return .good
        case L10n.acceptable:
            return .acceptable
        case L10n.poor:
            return .poor
        default:
            return .unknown
        }
    }
}
