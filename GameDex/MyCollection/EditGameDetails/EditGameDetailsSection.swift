//
//  EditGameDetailsSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 14/09/2023.
//

import Foundation

final class EditGameDetailsSection: Section {
    
    init(savedGame: SavedGame, platformName: String, editDelegate: EditFormDelegate) {
        super.init()
        self.position = 0
        
        let gameCellVM = ImageDescriptionCellViewModel(
            imageStringURL: savedGame.game.imageUrl,
            title: savedGame.game.title,
            subtitle1: platformName,
            subtitle2: savedGame.game.formattedReleaseDate,
            subtitle3: savedGame.game.description
        )
        self.cellsVM.append(gameCellVM)
        
        let isPhysicalCellVM = SegmentedControlCellViewModel(
            segments: [L10n.physical, L10n.digital],
            formType: GameFormType.isPhysical,
            value: savedGame.isPhysical ? L10n.physical : L10n.digital,
            editDelegate: editDelegate
        )
        self.cellsVM.append(isPhysicalCellVM)
        
        let yearOfAcquisitionCellVM = TextFieldCellViewModel(
            placeholder: L10n.yearOfAcquisition,
            formType: GameFormType.yearOfAcquisition,
            value: savedGame.acquisitionYear,
            editDelegate: editDelegate
        )
        self.cellsVM.append(yearOfAcquisitionCellVM)
        
        let conditionCellVM = TextFieldCellViewModel(
            placeholder: L10n.condition,
            formType: GameFormType.gameCondition(
                PickerViewModel(
                    data: [GameCondition.allCases.compactMap {
                        guard $0 != .unknown else {
                            return nil
                        }
                        return $0.value
                    }]
                )
            ),
            value: savedGame.gameCondition?.value,
            editDelegate: editDelegate
        )
        self.cellsVM.append(conditionCellVM)
        
        let completenessCellVM = TextFieldCellViewModel(
            placeholder: L10n.completeness,
            formType: GameFormType.gameCompleteness(
                PickerViewModel(
                    data: [GameCompleteness.allCases.compactMap {
                        guard $0 != .unknown else {
                            return nil
                        }
                        return $0.value
                    }]
                )
            ),
            value: savedGame.gameCompleteness?.value,
            editDelegate: editDelegate
        )
        self.cellsVM.append(completenessCellVM)
        
        let regionCellVM = TextFieldCellViewModel(
            placeholder: L10n.region,
            formType: GameFormType.gameRegion(
                PickerViewModel(
                    data: [GameRegion.allCases.map { $0.value }]
                )
            ),
            value: savedGame.gameRegion?.value,
            editDelegate: editDelegate
        )
        self.cellsVM.append(regionCellVM)
        
        let storageAreaCellVM = TextFieldCellViewModel(
            placeholder: L10n.storageArea,
            formType: GameFormType.storageArea,
            value: savedGame.storageArea,
            editDelegate: editDelegate
        )
        self.cellsVM.append(storageAreaCellVM)
        
        let personalRatingCellVM = StarRatingCellViewModel(
            title: L10n.personalRating,
            formType: GameFormType.rating,
            value: savedGame.rating,
            editDelegate: editDelegate
        )
        self.cellsVM.append(personalRatingCellVM)
        
        let otherDetailsCellVM = TextViewCellViewModel(
            title: L10n.otherDetails,
            formType: GameFormType.notes,
            value: savedGame.notes,
            editDelegate: editDelegate
        )
        self.cellsVM.append(otherDetailsCellVM)
    }

}
