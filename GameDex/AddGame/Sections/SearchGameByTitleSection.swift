//
//  SearchGameByTitleSection.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import Foundation

final class SearchGameByTitleSection: Section {
    
    var gamesQuery: [Game]
    
    init(gamesQuery: [Game], platform: Platform) {
        self.gamesQuery = gamesQuery
        super.init()
        self.position = 0
        
        for game in gamesQuery {
            let gameCellVM = BasicInfoCellViewModel(
                title: game.title,
                subtitle1: platform.title,
                subtitle2: game.genres,
                caption: game.image,
                navigationStyle: nil
            )
            self.cellsVM.append(gameCellVM)
        }
    }
}
