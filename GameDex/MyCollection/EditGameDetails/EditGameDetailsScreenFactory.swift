//
//  EditGameDetailsScreenFactory.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 14/09/2023.
//

import Foundation
import UIKit

struct EditGameDetailsScreenFactory: ScreenFactory {
    
    private let savedGame: SavedGame
    
    var viewController: UIViewController {
    }

    init(savedGame: SavedGame) {
        self.savedGame = savedGame
    }
}
