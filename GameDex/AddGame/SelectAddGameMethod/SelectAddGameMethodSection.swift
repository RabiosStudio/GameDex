//
//  SelectAddGameMethodSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 25/08/2023.
//

import Foundation

final class SelectAddGameMethodSection: Section {
    
    init(delegate: GameDetailsViewModelDelegate?) {
        super.init()
        self.position = 0
        
        let manualCellVM = BasicCardCellViewModel(
            cardType: SelectGameMethodCardType.manually,
            title: L10n.manually,
            description: L10n.manuallyDescription,
            screenFactory: SelectPlatformScreenFactory(delegate: delegate)
        )
        self.cellsVM.append(manualCellVM)
        
        let scanCellVM = BasicCardCellViewModel(
            cardType: SelectGameMethodCardType.scan,
            title: L10n.scan,
            description: L10n.comingSoon,
            screenFactory: nil
        )
        self.cellsVM.append(scanCellVM)
    }
}
