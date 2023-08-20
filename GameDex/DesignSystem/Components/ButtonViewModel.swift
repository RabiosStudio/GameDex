//
//  ButtonViewModel.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

struct ButtonViewModel {
    
    let buttonStyle: ButtonStyle
    
    let title: String
    
    init(title: String, buttonStyle: ButtonStyle) {
        self.title = title
        self.buttonStyle = buttonStyle
    }
}
