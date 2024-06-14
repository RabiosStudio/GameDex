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
        myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        super.init()
        self.position = 0
        
        for game in gamesQuery {
            let gameCellVM = BasicInfoCellViewModel(
                title: game.title,
                subtitle1: platform.title,
                subtitle2: game.formattedReleaseDate,
                caption: game.imageUrl,
                size: .regular,
                cellTappedCallback: {
                    let screenFactory = GameDetailsScreenFactory(
                        gameDetailsContext: .add(game: game),
                        platform: platform,
                        myCollectionDelegate: myCollectionDelegate
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
