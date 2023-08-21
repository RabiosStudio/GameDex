//
//  AddGameStepOneSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

final class AddGameStepOneSection: Section {
    
    override init() {
        super.init()
        self.position = 0
        
        let descriptionLabel = L10n.addGameStepOneDescription
        let descriptionCellVM = LabelCellViewModel(text: descriptionLabel)
        self.cellsVM.append(descriptionCellVM)

        let gameTitleCellVM = FormCellViewModel(title: L10n.title, shouldActiveTextField: true)
        self.cellsVM.append(gameTitleCellVM)

        let platformCellVM = FormCellViewModel(title: L10n.platform, shouldActiveTextField: false)
        self.cellsVM.append(platformCellVM)
    }
}
