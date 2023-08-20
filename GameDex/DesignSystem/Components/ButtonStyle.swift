//
//  ButtonStyle.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit

enum ButtonStyle: String {
    case small
    case regular
    case big
    
    var height: CGFloat {
        switch self {
        case .small:
            return UIDevice.current.userInterfaceIdiom == .phone ? 38 : 58
        case .regular:
            return UIDevice.current.userInterfaceIdiom == .phone ? 50 : 70
        case .big:
            return UIDevice.current.userInterfaceIdiom == .phone ? 66 : 90
        }
    }
}
