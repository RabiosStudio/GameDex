//
//  GameFormat.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 29/05/2024.
//

import Foundation
import UIKit

enum GameFormat: CaseIterable {
    case physical
    case digital
    
    var text: String {
        switch self {
        case .physical:
            L10n.physical
        case .digital:
            L10n.digital
        }
    }
    
    var image: UIImage {
        switch self {
        case .physical:
            return UIImage(systemName: "menucard")!
        case .digital:
            return UIImage(systemName: "cloud")!
        }
    }
}
