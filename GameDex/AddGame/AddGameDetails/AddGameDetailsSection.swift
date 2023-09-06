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
            textFieldType: .year
        )
        self.cellsVM.append(yearOfAcquisitionCellVM)
        
        let purchasePriceCellVM = TextFieldCellViewModel(
            placeholder: L10n.purchasePrice,
            textFieldType: .price
        )
        self.cellsVM.append(purchasePriceCellVM)
        
        let conditionCellVM = TextFieldCellViewModel(
            placeholder: L10n.condition,
            textFieldType: .picker(
                PickerViewModel(
                    data: [
                        Condition.mint.value,
                        Condition.good.value,
                        Condition.acceptable.value,
                        Condition.poor.value
                    ]
                )
            )
        )
        self.cellsVM.append(conditionCellVM)
        
        let completenessCellVM = TextFieldCellViewModel(
            placeholder: L10n.completeness,
            textFieldType: .picker(
                PickerViewModel(
                    data: [
                        Completeness.complete.value,
                        Completeness.noNotice.value,
                        Completeness.loose.value,
                        Completeness.sealed.value
                    ]
                )
            )
        )
        self.cellsVM.append(completenessCellVM)
        
        let regionCellVM = TextFieldCellViewModel(
            placeholder: L10n.region,
            textFieldType: .picker(
                PickerViewModel(
                    data: [
                        Region.pal.rawValue,
                        Region.ntscu.rawValue,
                        Region.ntscj.rawValue,
                        Region.ntscc.rawValue
                    ]
                )
            )
        )
        self.cellsVM.append(regionCellVM)
        
        let storageAreaCellVM = TextFieldCellViewModel(
            placeholder: L10n.storageArea,
            textFieldType: .text
        )
        self.cellsVM.append(storageAreaCellVM)
        
        let personalRatingCellVM = StarRatingCellViewModel(title: L10n.personalRating)
        self.cellsVM.append(personalRatingCellVM)
        
        let otherDetailsCellVM = TextViewCellViewModel(title: L10n.otherDetails)
        self.cellsVM.append(otherDetailsCellVM)
    }
}
