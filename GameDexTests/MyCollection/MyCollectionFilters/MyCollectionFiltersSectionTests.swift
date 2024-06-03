//
//  MyCollectionFiltersSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 23/05/2024.
//

import XCTest
@testable import GameDex

final class MyCollectionFiltersSectionTests: XCTestCase {
    
    func test_initWithoutFilters_ThenShouldSetPropertiesCorrectly() {
        // Given
        let editFormDelegate = FormDelegateMock()
        let section = MyCollectionFiltersSection(
            games: MockData.savedGames,
            selectedFilters: nil,
            formDelegate: editFormDelegate
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 6)
        
        guard let formCellsVM = section.cellsVM.filter({ cellVM in
            return cellVM is (any FormCellViewModel)
        }) as? [any FormCellViewModel] else {
            return
        }
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? GameFilterFormType else {
                XCTFail("Wrong type")
                return
            }
            switch formType {
            case .yearOfAcquisition:
                guard let acquisitionYearCellVM = formCellVM as? TextFieldCellViewModel,
                      let acquisitionYearCellVMFormType = acquisitionYearCellVM.formType as? GameFilterFormType else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(acquisitionYearCellVM.placeholder, L10n.yearOfAcquisition)
                var expectedData = [String]()
                for item in MockData.savedGames {
                    if let data = item.acquisitionYear {
                        expectedData.append(data)
                    }
                }
                XCTAssertEqual(
                    acquisitionYearCellVMFormType,
                    .yearOfAcquisition(
                        PickerViewModel(
                            data: [expectedData.sorted()]
                        )
                    )
                )
            case .gameCondition(_):
                guard let gameConditionCellVM = formCellVM as? TextFieldCellViewModel,
                      let gameConditionCellVMFormType = gameConditionCellVM.formType as? GameFilterFormType else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(gameConditionCellVM.placeholder, L10n.condition)
                XCTAssertEqual(
                    gameConditionCellVMFormType,
                    .gameCondition(
                        PickerViewModel(
                            data: [GameCondition.allCases.compactMap {
                                guard $0 != .unknown else {
                                    return nil
                                }
                                return $0.value
                            }]
                        )
                    )
                )
            case .gameCompleteness(_):
                guard let gameCompletenessCellVM = formCellVM as? TextFieldCellViewModel,
                      let gameCompletenessCellVMFormType = gameCompletenessCellVM.formType as? GameFilterFormType  else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(gameCompletenessCellVM.placeholder, L10n.completeness)
                XCTAssertEqual(
                    gameCompletenessCellVMFormType,
                    .gameCompleteness(
                        PickerViewModel(
                            data: [GameCompleteness.allCases.compactMap {
                                guard $0 != .unknown else {
                                    return nil
                                }
                                return $0.value
                            }]
                        )
                    )
                )
            case .gameRegion(_):
                guard let gameRegionCellVM = formCellVM as? TextFieldCellViewModel,
                      let gameRegionCellVMFormType = gameRegionCellVM.formType as? GameFilterFormType else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(gameRegionCellVM.placeholder, L10n.region)
                XCTAssertEqual(
                    gameRegionCellVMFormType,
                    .gameRegion(
                        PickerViewModel(
                            data: [GameRegion.allCases.map { $0.value }]
                        )
                    )
                )
            case .storageArea:
                guard let storageAreaCellVM = formCellVM as? TextFieldCellViewModel,
                      let storageAreaCellVMFormType = storageAreaCellVM.formType as? GameFilterFormType else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(storageAreaCellVM.placeholder, L10n.storageArea)
                
                var expectedData = [String]()
                for item in MockData.savedGames {
                    if let data = item.storageArea {
                        expectedData.append(data)
                    }
                }
                XCTAssertEqual(
                    storageAreaCellVMFormType,
                    .storageArea(
                        PickerViewModel(
                            data: [Array(Set(expectedData.sorted()))]
                        )
                    )
                )
            case .rating:
                guard let ratingCellVM = formCellVM as? StarRatingCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(ratingCellVM.title, L10n.personalRating)
            default:
                break
            }
        }
    }
    
    func test_initWithFilters_ThenShouldSetPropertiesCorrectly() {
        // Given
        let editFormDelegate = FormDelegateMock()
        let section = MyCollectionFiltersSection(
            games: MockData.savedGames,
            selectedFilters: MockData.gameFiltersWithMatchingGames,
            formDelegate: editFormDelegate
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 6)
        
        guard let formCellsVM = section.cellsVM.filter({ cellVM in
            return cellVM is (any FormCellViewModel)
        }) as? [any FormCellViewModel] else {
            return
        }
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? GameFilterFormType else {
                XCTFail("Wrong type")
                return
            }
            switch formType {
            case .yearOfAcquisition:
                guard let acquisitionYearCellVM = formCellVM as? TextFieldCellViewModel,
                      let acquisitionYearCellVMFormType = acquisitionYearCellVM.formType as? GameFilterFormType else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(acquisitionYearCellVM.placeholder, L10n.yearOfAcquisition)
                XCTAssertEqual(acquisitionYearCellVM.value, nil)
                var expectedData = [String]()
                for item in MockData.savedGames {
                    if let data = item.acquisitionYear {
                        expectedData.append(data)
                    }
                }
                XCTAssertEqual(
                    acquisitionYearCellVMFormType,
                    .yearOfAcquisition(
                        PickerViewModel(
                            data: [expectedData.sorted()]
                        )
                    )
                )
            case .gameCondition(_):
                var gameConditionText: String?
                guard let gameConditionCellVM = formCellVM as? TextFieldCellViewModel,
                      let gameConditionCellVMFormType = gameConditionCellVM.formType as? GameFilterFormType else {
                    XCTFail("Wrong type")
                    return
                }
                
                XCTAssertEqual(gameConditionCellVM.placeholder, L10n.condition)
                XCTAssertEqual(gameConditionCellVM.value, GameCondition.mint.value)
                XCTAssertEqual(
                    gameConditionCellVMFormType,
                    .gameCondition(
                        PickerViewModel(
                            data: [GameCondition.allCases.compactMap {
                                guard $0 != .unknown else {
                                    return nil
                                }
                                return $0.value
                            }]
                        )
                    )
                )
            case .gameCompleteness(_):
                guard let gameCompletenessCellVM = formCellVM as? TextFieldCellViewModel,
                      let gameCompletenessCellVMFormType = gameCompletenessCellVM.formType as? GameFilterFormType  else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(gameCompletenessCellVM.placeholder, L10n.completeness)
                XCTAssertEqual(gameCompletenessCellVM.value, GameCompleteness.complete.value)
                XCTAssertEqual(
                    gameCompletenessCellVMFormType,
                    .gameCompleteness(
                        PickerViewModel(
                            data: [GameCompleteness.allCases.compactMap {
                                guard $0 != .unknown else {
                                    return nil
                                }
                                return $0.value
                            }]
                        )
                    )
                )
            case .gameRegion(_):
                guard let gameRegionCellVM = formCellVM as? TextFieldCellViewModel,
                      let gameRegionCellVMFormType = gameRegionCellVM.formType as? GameFilterFormType else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(gameRegionCellVM.placeholder, L10n.region)
                XCTAssertEqual(gameRegionCellVM.value, GameRegion.pal.value)
                XCTAssertEqual(
                    gameRegionCellVMFormType,
                    .gameRegion(
                        PickerViewModel(
                            data: [GameRegion.allCases.map { $0.value }]
                        )
                    )
                )
            case .storageArea:
                guard let storageAreaCellVM = formCellVM as? TextFieldCellViewModel,
                      let storageAreaCellVMFormType = storageAreaCellVM.formType as? GameFilterFormType else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(storageAreaCellVM.placeholder, L10n.storageArea)
                XCTAssertEqual(storageAreaCellVM.value, nil)
                var expectedData = [String]()
                for item in MockData.savedGames {
                    if let data = item.storageArea {
                        expectedData.append(data)
                    }
                }
                XCTAssertEqual(
                    storageAreaCellVMFormType,
                    .storageArea(
                        PickerViewModel(
                            data: [Array(Set(expectedData.sorted()))]
                        )
                    )
                )
            case .rating:
                guard let ratingCellVM = formCellVM as? StarRatingCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(ratingCellVM.value, nil)
                XCTAssertEqual(ratingCellVM.title, L10n.personalRating)
            default:
                break
            }
        }
    }
}
