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
        selectedFilters: [GameFilter]?,
        editDelegate: EditFormDelegate
    ) {
        super.init()
        self.position = 0
        
        var acquisitionYearFilterValue: String?
        var conditionFilterValue: String?
        var completenessFilterValue: String?
        var regionFilterValue: String?
        var storageAreaFilterValue: String?
        var ratingFilterValue: Int?
        
        if let selectedFilters = selectedFilters {
            for filter in selectedFilters {
                switch filter {
                case let .acquisitionYear(value):
                    acquisitionYearFilterValue = value
                case let .gameCondition(value):
                    var gameConditionText: String?
                    if let gameCondition = GameCondition(rawValue: value) {
                        gameConditionText = gameCondition.value
                    }
                    conditionFilterValue = gameConditionText
                case let .gameCompleteness(value):
                    var gameCompletenessText: String?
                    if let gameCompleteness = GameCompleteness(rawValue: value) {
                        gameCompletenessText = gameCompleteness.value
                    }
                    completenessFilterValue = gameCompletenessText
                case let .gameRegion(value):
                    var gameRegionText: String?
                    if let gameRegion = GameRegion(rawValue: value) {
                        gameRegionText = gameRegion.value
                    }
                    regionFilterValue = gameRegionText
                case let .storageArea(value):
                    storageAreaFilterValue = value
                case let .rating(value):
                    ratingFilterValue = value
                }
            }
        }
        
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
                formType: GameFilterFormType.yearOfAcquisition(
                    PickerViewModel(
                        data: [acquisitionYearArray.sorted()]
                    )
                ),
                value: acquisitionYearFilterValue ?? nil,
                editDelegate: editDelegate
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
            value: conditionFilterValue ?? nil,
            editDelegate: editDelegate
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
            value: completenessFilterValue ?? nil,
            editDelegate: editDelegate
        )
        self.cellsVM.append(completenessCellVM)
        
        let regionCellVM = TextFieldCellViewModel(
            placeholder: L10n.region,
            formType: GameFilterFormType.gameRegion(
                PickerViewModel(
                    data: [GameRegion.allCases.map { $0.value }]
                )
            ),
            value: regionFilterValue ?? nil,
            editDelegate: editDelegate
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
                value: storageAreaFilterValue ?? nil,
                editDelegate: editDelegate
            )
            self.cellsVM.append(storageAreaCellVM)
        }
        
        let personalRatingCellVM = StarRatingCellViewModel(
            title: L10n.personalRating,
            formType: GameFilterFormType.rating,
            value: ratingFilterValue ?? nil,
            editDelegate: editDelegate
        )
        self.cellsVM.append(personalRatingCellVM)
    }
}
