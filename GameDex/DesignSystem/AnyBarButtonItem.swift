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
    case add
    case delete
    case search
    case filter(active: Bool)
    case clear
    
    enum Position {
        case leading
        case trailing
    }
    
    var position: Position {
        switch self {
        case .clear:
            return .leading
        default:
            return .trailing
        }
    }
    
    func content<T>() -> T? {
        switch self {
        case .close:
            return UIImage(systemName: "xmark")! as? T
        case .add:
            return UIImage(systemName: "plus")! as? T
        case .delete:
            return UIImage(systemName: "trash")! as? T
        case .search:
            return UIImage(systemName: "magnifyingglass")! as? T
        case let .filter(active):
            return UIImage(systemName: active ? "line.3.horizontal.decrease.circle.fill" : "line.3.horizontal.decrease.circle")! as? T
        case .clear:
            return L10n.clearAll as? T
        }
    }
}
