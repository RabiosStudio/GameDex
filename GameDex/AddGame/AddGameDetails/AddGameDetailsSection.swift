//
//  AddGameDetailsSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import Foundation

final class AddGameDetailsSection: Section {
    
    init(
        game: Game,
        platform: Platform,
        gameForm: GameForm,
        formDelegate: FormDelegate
    ) {
        super.init()
        self.position = 0
        
        let gameCellVM = ImageDescriptionCellViewModel(
            imageStringURL: game.imageUrl,
            title: game.title,
            subtitle1: platform.title,
            subtitle2: game.formattedReleaseDate,
            subtitle3: game.description
        )
        self.cellsVM.append(gameCellVM)
        
        let isPhysicalCellVM = SegmentedControlCellViewModel(
            segments: [
                SegmentItemViewModel(title: GameFormat.physical.text, image: GameFormat.physical.image),
                SegmentItemViewModel(title: GameFormat.digital.text, image: GameFormat.digital.image)
            ],
            formType: GameFormType.isPhysical,
            value: gameForm.isPhysical ? GameFormat.physical.text : GameFormat.digital.text,
            formDelegate: formDelegate
        )
        self.cellsVM.append(isPhysicalCellVM)
        
        let yearOfAcquisitionCellVM = TextFieldCellViewModel(
            placeholder: L10n.yearOfAcquisition,
            formType: GameFormType.acquisitionYear,
            value: gameForm.acquisitionYear,
            formDelegate: formDelegate
        )
        self.cellsVM.append(yearOfAcquisitionCellVM)
        
        if gameForm.isPhysical {
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
                value: gameForm.gameCondition?.value,
                formDelegate: formDelegate
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
                value: gameForm.gameCompleteness?.value,
                formDelegate: formDelegate
            )
            self.cellsVM.append(completenessCellVM)
            
            let regionCellVM = TextFieldCellViewModel(
                placeholder: L10n.region,
                formType: GameFormType.gameRegion(
                    PickerViewModel(
                        data: [GameRegion.allCases.map { $0.value }]
                    )
                ),
                value: gameForm.gameRegion?.value,
                formDelegate: formDelegate
            )
            self.cellsVM.append(regionCellVM)
            
            let storageAreaCellVM = TextFieldCellViewModel(
                placeholder: L10n.storageArea,
                formType: GameFormType.storageArea,
                value: gameForm.storageArea,
                formDelegate: formDelegate
            )
            self.cellsVM.append(storageAreaCellVM)
        }
        
        let personalRatingCellVM = StarRatingCellViewModel(
            title: L10n.personalRating,
            formType: GameFormType.rating,
            value: gameForm.rating,
            formDelegate: formDelegate
        )
        self.cellsVM.append(personalRatingCellVM)
        
        let otherDetailsCellVM = TextViewCellViewModel(
            title: L10n.otherDetails,
            formType: GameFormType.notes,
            value: gameForm.notes,
            formDelegate: formDelegate
        )
        self.cellsVM.append(otherDetailsCellVM)
    }
}
