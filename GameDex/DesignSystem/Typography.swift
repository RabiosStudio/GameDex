//
//  Typography.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 16/08/2023.
//

import Foundation
import UIKit

enum Typography {
    case largeTitle
    case title1
    case title2
    case title2bold
    case title3
    case title3bold
    case headline
    case subheadline
    case body
    case bodyBold
    case callout
    case calloutBold
   
    private var defaultSize: CGFloat {
        switch self {
        case .largeTitle:
            return 28
        case .title1:
            return 24
        case .title2, .title2bold:
            return 20
        case .title3, .title3bold:
            return 18
        case .headline:
            return 16
        case .subheadline:
            return 14
        case .body, .bodyBold:
            return 14
        case .callout, .calloutBold:
            return 18
        }
    }
    
    var systemSize: CGFloat {
        return UIDevice.current.userInterfaceIdiom == .phone ? defaultSize : defaultSize * 1.25
    }
    
    private var weight: UIFont.Weight {
        switch self {
        case .bodyBold, .calloutBold, .title2bold, .title3bold:
            return .bold
        default:
            return .medium
        }
    }
    
    var font: UIFont {
        return .systemFont(ofSize: self.systemSize, weight: self.weight)
    }
}
