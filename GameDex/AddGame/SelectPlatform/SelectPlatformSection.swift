//
//  SelectPlatformSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectPlatformSection: Section {
    
    init(platforms: [Platform], myCollectionDelegate: MyCollectionViewModelDelegate?) {
        super.init()
        self.position = 0
        
        for platform in platforms {
            let platformCellVM = BasicInfoCellViewModel(
                title: platform.title,
                caption: platform.imageUrl,
                size: .small,
                cellTappedCallback: {
                    let screenFactory = SearchGameByTitleScreenFactory(
                        platform: platform, 
                        progress: DesignSystem.twoThirdProgress,
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
