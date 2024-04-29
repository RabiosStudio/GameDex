//
//  Condition.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 06/09/2023.
//

import Foundation

enum GameCondition: CaseIterable {
    case mint
    case veryGood
    case good
    case acceptable
    case poor
 
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
        }
    }
}
