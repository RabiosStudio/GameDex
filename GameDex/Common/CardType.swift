//
//  CardType.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import Foundation
import UIKit

enum CardType {
    case emailAuth
    case appleAuth
    case facebookAuth
    case googleAuth
    
    var titleColor: UIColor {
        switch self {
        case .emailAuth:
            return UIColor.primaryBackgroundColor
        case .appleAuth:
            return UIColor.primaryBackgroundColor
        case .facebookAuth:
            return UIColor.primaryBackgroundColor
        case .googleAuth:
            return UIColor.secondaryColor
        }
    }
    
    var backgroundColor: UIColor {
        switch self {
        case .emailAuth:
            return UIColor.primaryColor
        case .appleAuth:
            return UIColor.secondaryColor
        case .facebookAuth:
            return UIColor(red: 66/255.0, green: 103/255.0, blue: 178/255.0, alpha: 1.0)
        case .googleAuth:
            return UIColor.primaryBackgroundColor
        }
    }
    
    var image: UIImage {
        switch self {
        case .emailAuth:
            return UIImage(systemName: "envelope.fill")!.withTintColor(.primaryBackgroundColor, renderingMode: .alwaysOriginal)
        case .appleAuth:
            return UIImage(systemName: "applelogo")!.withTintColor(.primaryBackgroundColor, renderingMode: .alwaysOriginal)
        case .facebookAuth:
            return Asset.facebookLogo.image
        case .googleAuth:
            return Asset.googleLogo.image
        }
    }
}
