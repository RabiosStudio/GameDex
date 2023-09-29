//
//  MyCollectionSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation

final class MyCollectionSection: Section {
    
    init(platforms: [Platform],
         gameDetailsDelegate: GameDetailsViewModelDelegate?
    ) {
        super.init()
        self.position = 0
        let platforms = platforms.sorted {
            $0.title > $1.title
        }
        
        // Check all games in collection and add those on the corresponding platform in an array that we will pass to the cell
        for platform in platforms {
            let gameArrayByPlatform = platform.games
            
            guard let gameArray = gameArrayByPlatform else { return }
            
            let text = gameArray.count > 1 ? L10n.games : L10n.game
            
            let labelCellVM = LabelCellViewModel(
                primaryText: platform.title,
                secondaryText: "\(gameArray.count) \(text)",
                cellTappedCallback: {
                    let screenFactory = MyCollectionByPlatformsScreenFactory(
                        platform: platform,
                        gameDetailsDelegate: gameDetailsDelegate
                    )
                    Routing.shared.route(
                        navigationStyle: .push(
                            controller: screenFactory.viewController
                        )
                    )
                }
            )
            self.cellsVM.append(labelCellVM)
        }
    }
}
