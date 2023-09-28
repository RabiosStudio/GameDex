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
            cardType: SelectAddGameMethodCardType.manually,
            title: L10n.manually,
            description: L10n.manuallyDescription
        ) {
            let screenFactory = SelectPlatformScreenFactory(delegate: delegate)
            Routing.shared.route(
                navigationStyle: .push(
                    controller: screenFactory.viewController
                )
            )
        }
        self.cellsVM.append(manualCellVM)
        
        let scanCellVM = BasicCardCellViewModel(
            cardType: SelectAddGameMethodCardType.scan,
            title: L10n.scan,
            description: L10n.comingSoon
        )
        self.cellsVM.append(scanCellVM)
    }
}
