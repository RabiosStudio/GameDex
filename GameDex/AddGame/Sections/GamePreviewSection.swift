//
//  GamePreviewSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

class GamePreviewSection: Section {
    
    var game: Game
    
    init(game: Game) {
        self.game = game
        super.init()
        self.position = 0
        
        let gameCellVM = ImageDescriptionCellViewModel(
            imageStringURL: game.image,
            title: game.title,
            subtitle1: game.platform,
            subtitle2: game.description
        )
        self.cellsVM.append(gameCellVM)
    }
}
