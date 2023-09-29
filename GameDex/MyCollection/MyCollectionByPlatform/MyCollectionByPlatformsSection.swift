//
//  MyCollectionByPlatformsSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation

final class MyCollectionByPlatformsSection: Section {
    
    init(games: [SavedGame], platformName: String, gameDetailsDelegate: GameDetailsViewModelDelegate?) {
        super.init()
        self.position = 0
        
        let sortedCollection = games.sorted { $0.game.title < $1.game.title }
        
        for item in sortedCollection {
            let gameCellVM = BasicInfoCellViewModel(
                title: item.game.title,
                subtitle1: platformName,
                subtitle2: item.game.releaseDate?.convertToString(),
                caption: item.game.imageURL,
                cellTappedCallback: {
                    let screenFactory = EditGameDetailsScreenFactory(
                        savedGame: item,
                        platformName: platformName,
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
