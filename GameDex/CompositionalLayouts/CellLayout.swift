//
//  CellLayout.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

struct CellLayout {
    var size: CellSize
    var horizontalSpacing: CellSpacing
    var verticalSpacing: CellSpacing
}

enum CellSize {
    case small
    case regular
    case big
    
    var value: CGFloat {
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

enum CellSpacing {
    case none
    case small
    case regular
    
    var value: CGFloat {
        switch self {
        case .none:
            return .zero
        case .small:
            return DesignSystem.paddingSmall
        case .regular:
            return DesignSystem.paddingRegular
        }
    }
}
