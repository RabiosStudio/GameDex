//
//  AddGameDetailsSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class AddGameDetailsSection: Section {
    
    var game: Game
    
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
            title: L10n.yearOfAcquisition,
            shouldActiveTextField: true,
            textFieldType: .numbers
        )
        self.cellsVM.append(yearOfAcquisitionCellVM)
        
        let purchasePrice = TextFieldCellViewModel(
            title: L10n.purchasePrice,
            shouldActiveTextField: false,
            textFieldType: .numbers
        )
        self.cellsVM.append(purchasePrice)
        
        let condition = TextFieldCellViewModel(
            title: L10n.condition,
            shouldActiveTextField: false,
            textFieldType: .text
        )
        self.cellsVM.append(condition)
        
        let storageArea = TextFieldCellViewModel(
            title: L10n.storageArea,
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
