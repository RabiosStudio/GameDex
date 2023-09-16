//
//  SelectPlatformSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectPlatformSection: Section {
    
    init(platforms: [Platform], addGameDelegate: AddGameDetailsViewModelDelegate?) {
        super.init()
        self.position = 0
        
        for platform in platforms {
            let labelCellVM = LabelCellViewModel(
                mainText: platform.title,
                optionalText: nil,
                screenFactory: SearchGameByTitleScreenFactory(
                    platform: platform,
                    addGameDelegate: addGameDelegate
                )
            )
            
            self.cellsVM.append(labelCellVM)
        }
    }
}
