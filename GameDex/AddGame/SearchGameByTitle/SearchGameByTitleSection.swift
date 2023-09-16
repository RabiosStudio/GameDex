//
//  SearchGameByTitleSection.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation

final class SearchGameByTitleSection: Section {
    
    init(
        gamesQuery: [Game],
        platform: Platform,
        addGameDelegate: AddGameDetailsViewModelDelegate?
    ) {
        super.init()
        self.position = 0
        
        for game in gamesQuery {
            let gameCellVM = BasicInfoCellViewModel(
                title: game.title,
                subtitle1: platform.title,
                subtitle2: game.description,
                caption: game.imageURL,
                screenFactory: AddGameDetailsScreenFactory(
                    game: game,
                    addGameDelegate: addGameDelegate
                )
            )
            self.cellsVM.append(gameCellVM)
        }
    }
}
