//
//  MyCollectionByPlatformsSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation

final class MyCollectionByPlatformsSection: Section {
  
    init(gamesCollection: [SavedGame], gameDetailsDelegate: GameDetailsViewModelDelegate?) {
        super.init()
        self.position = 0
        
        let sortedCollection = gamesCollection.sorted { $0.game.title < $1.game.title }
        
        for item in sortedCollection {
            let gameCellVM = BasicInfoCellViewModel(
                title: item.game.title,
                subtitle1: nil,
                subtitle2: item.game.description,
                caption: item.game.imageURL,
                screenFactory: EditGameDetailsScreenFactory(
                    savedGame: item,
                    gameDetailsDelegate: gameDetailsDelegate)
            )
            self.cellsVM.append(gameCellVM)
        }
    }
}
