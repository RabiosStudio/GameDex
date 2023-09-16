//
//  MyCollectionByPlatformsSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation

final class MyCollectionByPlatformsSection: Section {
    
    var gamesCollection: [SavedGame]
    
    init(gamesCollection: [SavedGame]) {
        self.gamesCollection = gamesCollection
        super.init()
        self.position = 0
        
        for item in gamesCollection {
            let gameCellVM = BasicInfoCellViewModel(
                title: item.game.title,
                subtitle1: nil,
                subtitle2: item.game.description,
                caption: item.game.imageURL,
                screenFactory: EditGameDetailsScreenFactory(savedGame: item)
            )
            self.cellsVM.append(gameCellVM)
        }
    }
}
