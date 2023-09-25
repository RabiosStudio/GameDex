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
            return .white
        case .appleAuth:
            return .white
        case .facebookAuth:
            return .white
        case .googleAuth:
            return .black
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
            return .white
        }
    }
    
    var image: UIImage? {
        switch self {
        case .emailAuth:
            return UIImage(systemName: "envelope.fill")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .appleAuth:
            return UIImage(systemName: "applelogo")?.withTintColor(.white, renderingMode: .alwaysOriginal)
        case .facebookAuth:
            return Asset.facebookLogo.image
        case .googleAuth:
            return Asset.googleLogo.image
        }
    }
}
