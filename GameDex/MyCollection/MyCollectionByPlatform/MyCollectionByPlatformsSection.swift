//
//  MyCollectionByPlatformsSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation

final class MyCollectionByPlatformsSection: Section {
    
    init(games: [SavedGame], platform: Platform, myCollectionDelegate: MyCollectionViewModelDelegate?) {
        super.init()
        self.position = 0
        
        let sortedCollection = games.sorted { $0.game.title.lowercased() < $1.game.title.lowercased() }
        
        for item in sortedCollection {
            let gameCellVM = BasicInfoCellViewModel(
                title: item.game.title,
                subtitle1: platform.title,
                subtitle2: item.game.formattedReleaseDate,
                caption: item.game.imageUrl,
                icon: item.isPhysical ? GameFormat.physical.image : GameFormat.digital.image,
                cellTappedCallback: {
                    let screenFactory = GameDetailsScreenFactory(
                        gameDetailsContext: .edit(savedGame: item),
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
