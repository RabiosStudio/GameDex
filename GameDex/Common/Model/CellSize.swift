//
//  CellSize.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/09/2023.
//

import Foundation

enum CellSize {
    case small
    case regular
    case big
    
    var height: CGFloat {
        switch self {
        case .small:
            return DesignSystem.sizeSmall
        case .regular:
            return DesignSystem.sizeRegular
        case .big:
            return DesignSystem.sizeBig
        }
    }
}
