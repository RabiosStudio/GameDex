//
//  BarButtonItem.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 18/08/2023.
//

import Foundation
import UIKit

class BarButtonItem: UIBarButtonItem {
    
    internal var actionHandler: (() -> Void)?
    
    convenience init(image: UIImage, actionHandler: (() -> Void)?) {
        self.init(image: image, style: .plain, target: nil, action: #selector(barButtonItemPressed))
        self.target = self
        self.actionHandler = actionHandler
    }
    
    @objc func barButtonItemPressed(sender: UIBarButtonItem) {
        actionHandler?()
    }
}
