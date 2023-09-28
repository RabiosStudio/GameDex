//
//  SelectPlatformSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectPlatformSection: Section {
    
    init(platforms: [Platform], gameDetailsDelegate: GameDetailsViewModelDelegate?) {
        super.init()
        self.position = 0
        
        for platform in platforms {
            let labelCellVM = LabelCellViewModel(
                primaryText: platform.title,
                secondaryText: nil,
                cellTappedCallback: {
                    let screenFactory = SearchGameByTitleScreenFactory(
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
