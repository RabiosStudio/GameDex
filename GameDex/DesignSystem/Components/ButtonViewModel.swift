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
    let buttonTitle: String
    let buttonBackgroundColor: UIColor
    
    init(
        isEnabled: Bool = true,
        buttonTitle: String,
        buttonBackgroundColor: UIColor
    ) {
        self.isEnabled = isEnabled
        self.buttonTitle = buttonTitle
        self.buttonBackgroundColor = buttonBackgroundColor
    }
}
