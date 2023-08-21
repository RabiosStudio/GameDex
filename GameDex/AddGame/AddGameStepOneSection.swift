//
//  AddGameStepOneSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/08/2023.
//

import Foundation

class AddGameStepOneSection: Section {
    
    override init() {
        super.init()
        self.position = 0

        let gameTitle = FormCollectionCellViewModel(title: L10n.title, shouldActiveTextField: true)
        self.cellsVM.append(gameTitle)

        let platform = FormCollectionCellViewModel(title: L10n.platform, shouldActiveTextField: false)
        self.cellsVM.append(platform)
    }
}
