//
//  AuthCardType.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

enum AuthCardType: CardType {
    case emailAuth
    case appleAuth
    case facebookAuth
    case googleAuth
    
    var height: CGFloat {
        return DesignSystem.sizeVerySmall
    }
    
    var textColor: UIColor {
        switch self {
        case .emailAuth:
            return .alwaysWhite
        case .appleAuth:
            return .alwaysWhite
        case .facebookAuth:
            return .alwaysWhite
        case .googleAuth:
            return .alwaysBlack
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .emailAuth:
            return .primaryColor
        case .appleAuth:
            return .appleColor
        case .facebookAuth:
            return .facebookColor
        case .googleAuth:
            return .alwaysWhite
        }
    }
    
    var image: UIImage {
        switch self {
        case .emailAuth:
            return UIImage(systemName: "envelope.fill")!.withTintColor(.alwaysWhite, renderingMode: .alwaysOriginal)
        case .appleAuth:
            return UIImage(systemName: "applelogo")!.withTintColor(.alwaysWhite, renderingMode: .alwaysOriginal)
        case .facebookAuth:
            return Asset.facebookLogo.image
        case .googleAuth:
            return Asset.googleLogo.image
        }
    }
}
