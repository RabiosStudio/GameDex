//
//  ButtonViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation
import UIKit

struct ButtonViewModel {
    let isEnabled: Bool
    let title: String
    let backgroundColor: UIColor
    
    init(
        isEnabled: Bool = true,
        title: String,
        backgroundColor: UIColor
    ) {
        self.isEnabled = isEnabled
        self.title = title
        self.backgroundColor = backgroundColor
    }
}
