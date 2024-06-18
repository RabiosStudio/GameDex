//
//  MyCollectionFiltersSection.swift
//  GameDex
//
//  Created by Gabrielle Dalbera on 17/05/2024.
//

import Foundation

final class MyCollectionFiltersSection: Section {
    
    init(
        games: [SavedGame],
        gameFilterForm: GameFilterForm,
        formDelegate: FormDelegate
    ) {
        super.init()
        self.position = 0
        
        var isPhysicalValue: String?
        if let isPhysical = gameFilterForm.isPhysical {
            isPhysicalValue = isPhysical ? GameFormat.physical.text : GameFormat.digital.text
        }
        
        let isPhysicalCellVM = TextFieldCellViewModel(
            placeholder: L10n.gameFormat,
            formType: GameFilterFormType.isPhysical(
                PickerViewModel(
                    data: [[GameFormat.physical.text, GameFormat.digital.text, L10n.any]]
                )
            ),
            value: isPhysicalValue,
            formDelegate: formDelegate
        )
        self.cellsVM.append(isPhysicalCellVM)
        
        let acquisitionYearArray = Array(
            Set(
                games.compactMap { aGame in
                    return aGame.acquisitionYear
                }
            )
        )
        if !acquisitionYearArray.isEmpty {
            let yearOfAcquisitionCellVM = TextFieldCellViewModel(
                placeholder: L10n.yearOfAcquisition,
                formType: GameFilterFormType.acquisitionYear(
                    PickerViewModel(
                        data: [acquisitionYearArray.sorted()]
                    )
                ),
                value: gameFilterForm.acquisitionYear ?? nil,
                formDelegate: formDelegate
            )
            self.cellsVM.append(yearOfAcquisitionCellVM)
        }
        
        let conditionCellVM = TextFieldCellViewModel(
            placeholder: L10n.condition,
            formType: GameFilterFormType.gameCondition(
                PickerViewModel(
                    data: [GameCondition.allCases.compactMap {
                        guard $0 != .unknown else {
                            return nil
                        }
                        return $0.value
                    }]
                )
            ),
            value: gameFilterForm.gameCondition?.value ?? nil,
            formDelegate: formDelegate
        )
        self.cellsVM.append(conditionCellVM)
        
        let completenessCellVM = TextFieldCellViewModel(
            placeholder: L10n.completeness,
            formType: GameFilterFormType.gameCompleteness(
                PickerViewModel(
                    data: [GameCompleteness.allCases.compactMap {
                        guard $0 != .unknown else {
                            return nil
                        }
                        return $0.value
                    }]
                )
            ),
            value: gameFilterForm.gameCompleteness?.value ?? nil,
            formDelegate: formDelegate
        )
        self.cellsVM.append(completenessCellVM)
        
        let regionCellVM = TextFieldCellViewModel(
            placeholder: L10n.region,
            formType: GameFilterFormType.gameRegion(
                PickerViewModel(
                    data: [GameRegion.allCases.map { $0.value }]
                )
            ),
            value: gameFilterForm.gameRegion?.value ?? nil,
            formDelegate: formDelegate
        )
        self.cellsVM.append(regionCellVM)
        
        let storageAreaArray = Array(
            Set(
                games.compactMap { aGame in
                    return aGame.storageArea
                }
            )
        )
        if !storageAreaArray.isEmpty {
            let storageAreaCellVM = TextFieldCellViewModel(
                placeholder: L10n.storageArea,
                formType: GameFilterFormType.storageArea(
                    PickerViewModel(
                        data: [storageAreaArray.sorted()]
                    )
                ),
                value: gameFilterForm.storageArea ?? nil,
                formDelegate: formDelegate
            )
            self.cellsVM.append(storageAreaCellVM)
        }
        
        let personalRatingCellVM = StarRatingCellViewModel(
            title: L10n.personalRating,
            formType: GameFilterFormType.rating,
            value: gameFilterForm.rating ?? nil,
            formDelegate: formDelegate
        )
        self.cellsVM.append(personalRatingCellVM)
    }
}
