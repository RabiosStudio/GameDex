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
            let gameCellVM = BasicInfoCellViewModel(
                title: game.title,
                subtitle1: platform.title,
                subtitle2: game.releaseDate?.convertToString(),
                caption: game.imageURL,
                cellTappedCallback: {
                    let screenFactory = AddGameDetailsScreenFactory(
                        game: game,
                        platform: platform,
                        gameDetailsDelegate: gameDetailsDelegate
                    )
                    Routing.shared.route(
                        navigationStyle: .push(
                            screenFactory: screenFactory
                        )
                    )
                }
            )
            self.cellsVM.append(gameCellVM)
        }
    }
}
