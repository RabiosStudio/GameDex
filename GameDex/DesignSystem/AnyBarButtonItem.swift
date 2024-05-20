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
    case filter
    
    func image() -> UIImage {
        switch self {
        case .close:
            return UIImage(systemName: "xmark")!
        case .add:
            return UIImage(systemName: "plus")!
        case .delete:
            return UIImage(systemName: "trash")!
        case .search:
            return UIImage(systemName: "magnifyingglass")!
        case .filter:
            return UIImage(systemName: "line.3.horizontal.decrease")!
        }
    }
}
