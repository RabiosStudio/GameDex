//
//  BarButtonConverter.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 22/05/2024.
//

import Foundation
import UIKit

enum BarButtonConverter {
    
    // MARK: - AnyBarButtonItem to BarButtonItem
    
    static func convert(
        item: AnyBarButtonItem,
        actionHandler: (() -> Void)?
    ) -> BarButtonItem? {
        if let image: UIImage = item.content() {
            return BarButtonItem(
                image: image,
                title: nil,
                actionHandler: actionHandler
            )
        } else if let title: String = item.content() {
            return BarButtonItem(
                image: nil,
                title: title,
                actionHandler: actionHandler
            )
        } else {
            return nil
        }
    }
}
