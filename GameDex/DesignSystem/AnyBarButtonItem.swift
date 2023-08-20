//
//  AnyBarButtonItem.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

enum AnyBarButtonItem {
    case close
    
    func image() -> UIImage {
        switch self {
        case .close:
            return UIImage(systemName: "xmark")!
        }
    }
}