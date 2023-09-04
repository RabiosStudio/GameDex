//
//  GameFormBasicSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class GameFormBasicSection: Section {
    
    override init() {
        super.init()
        self.position = 1
        
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
    }
}
