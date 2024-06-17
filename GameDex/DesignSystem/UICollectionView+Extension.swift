//
//  UICollectionView+Extension.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 14/06/2024.
//

import Foundation
import UIKit

extension UICollectionView {
    public func scrollToItem(at indexPath: IndexPath, at scrollPosition: UICollectionView.ScrollPosition, adjustment: CGFloat = .zero, withAdjustmentDuration duration: TimeInterval = 0.5) {
        self.scrollToItem(at: indexPath, at: scrollPosition, animated: true)
        UIView.animate(withDuration: duration) {
            switch scrollPosition {
            case .top, .bottom, .centeredVertically:
                self.contentOffset.y += adjustment
            case .left, .right, .centeredHorizontally:
                self.contentOffset.x += adjustment
            default:
                break
            }
        }
    }
}
