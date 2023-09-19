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
        gameDetailsDelegate: GameDetailsViewModelDelegate?
    ) {
        super.init()
        self.position = 0
        
        for game in gamesQuery {
            let releaseDate = DataConverter.convertDateToString(date: game.releaseDate ?? Date())
            
            let gameCellVM = BasicInfoCellViewModel(
                title: game.title,
                subtitle1: platform.title,
                subtitle2: releaseDate,
                caption: game.imageURL,
                screenFactory: AddGameDetailsScreenFactory(
                    game: game,
                    gameDetailsDelegate: gameDetailsDelegate
                )
            )
            self.cellsVM.append(gameCellVM)
        }
    }
}
