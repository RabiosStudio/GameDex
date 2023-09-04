//
//  CellLayout.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation
import UIKit

struct CellLayout {
    let size: CellSize
    let horizontalSpacing: CellSpacing
    let verticalSpacing: CellSpacing
}

enum CellSize {
    case verySmall
    case small
    case regular
    case big
    case veryBig
    
    var value: CGFloat {
        switch self {
        case .verySmall:
            return DesignSystem.sizeVerySmall
        case .small:
            return DesignSystem.sizeSmall
        case .regular:
            return DesignSystem.sizeRegular
        case .big:
            return DesignSystem.sizeBig
        case .veryBig:
            return DesignSystem.sizeVeryBig
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
