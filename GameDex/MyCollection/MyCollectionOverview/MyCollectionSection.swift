//
//  MyCollectionSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 13/09/2023.
//

import Foundation

final class MyCollectionSection: Section {
    
    init(platforms: [Platform],
         myCollectionDelegate: MyCollectionViewModelDelegate?
    ) {
        super.init()
        self.position = 0
        let platforms = platforms.sorted {
            $0.title < $1.title
        }
        
        // Check all games in collection and add those on the corresponding platform in an array that we will pass to the cell
        for platform in platforms {
            let gameArrayByPlatform = platform.games
            
            guard let gameArray = gameArrayByPlatform else { return }
            
            let text = gameArray.count > 1 ? L10n.games : L10n.game
            
            let platformCellVM = BasicInfoCellViewModel(
                title: platform.title,
                subtitle1: "\(gameArray.count) \(text)",
                subtitle2: nil,
                caption: platform.imageUrl,
                cellTappedCallback: {
                    let screenFactory = MyCollectionByPlatformsScreenFactory(
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
            self.cellsVM.append(platformCellVM)
        }
    }
}
