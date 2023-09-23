//
//  SelectGameMethodCardType.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

enum SelectGameMethodCardType: CardType {
    case manually
    case scan
    
    var height: CGFloat {
        return DesignSystem.sizeRegular
    }
    
    var textColor: UIColor {
        return .secondaryColor
    }
    
    var backgroundColor: UIColor {
        return .primaryBackgroundColor
    }
    
    var image: UIImage {
        switch self {
        case .manually:
            return Asset.form.image
        case .scan:
            return Asset.barcode.image
        }
    }
}
