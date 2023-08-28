//
//  SelectPlatformSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectPlatformSection: Section {
    
    var platforms: [Platform]
    
    init(platforms: [Platform]) {
        self.platforms = platforms
        super.init()
        self.position = 0
        
        for platform in platforms {
            let labelCellVM = LabelCellViewModel(text: platform.title)
            self.cellsVM.append(labelCellVM)
        }
    }
}
