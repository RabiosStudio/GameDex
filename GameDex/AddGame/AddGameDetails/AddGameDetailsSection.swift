//
//  AddGameDetailsSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class AddGameDetailsSection: Section {
    
    private let game: Game
    
    init(game: Game) {
        self.game = game
        super.init()
        self.position = 0
        
        let gameCellVM = ImageDescriptionCellViewModel(
            imageStringURL: game.image,
            title: game.title,
            subtitle1: game.platform,
            subtitle2: game.description
        )
        self.cellsVM.append(gameCellVM)
        
        let yearOfAcquisitionCellVM = TextFieldCellViewModel(
            placeholder: L10n.yearOfAcquisition,
            shouldActiveTextField: true,
            textFieldType: .numbers
        )
        self.cellsVM.append(yearOfAcquisitionCellVM)
        
        let purchasePrice = TextFieldCellViewModel(
            placeholder: L10n.purchasePrice,
            shouldActiveTextField: false,
            textFieldType: .numbers
        )
        self.cellsVM.append(purchasePrice)
        
        let condition = TextFieldCellViewModel(
            placeholder: L10n.condition,
            shouldActiveTextField: false,
            textFieldType: .text
        )
        self.cellsVM.append(condition)
        
        let storageArea = TextFieldCellViewModel(
            placeholder: L10n.storageArea,
            shouldActiveTextField: false,
            textFieldType: .text
        )
        self.cellsVM.append(storageArea)
        
        let personalRating = StarRatingCellViewModel(title: L10n.personalRating)
        self.cellsVM.append(personalRating)
        
        let otherDetails = TextViewCellViewModel(title: L10n.otherDetails)
        self.cellsVM.append(otherDetails)
    }
}
