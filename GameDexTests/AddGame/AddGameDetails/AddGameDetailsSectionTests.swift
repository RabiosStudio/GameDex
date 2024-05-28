//
//  AddGameDetailsSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 05/09/2023.
//

import XCTest
@testable import GameDex

final class AddGameDetailsSectionTests: XCTestCase {
    
    // MARK: Tests
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = AddGameDetailsSection(game: MockData.game, platform: MockData.platform)
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 8)
        
        guard let gameCellVM = section.cellsVM.first as? ImageDescriptionCellViewModel else {
            XCTFail("Wrong type")
            return
        }
        
        XCTAssertEqual(gameCellVM.title, "Title")
        XCTAssertEqual(gameCellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(gameCellVM.subtitle2, L10n.releaseDate + " : " + Date.now.convertToString())
        XCTAssertEqual(gameCellVM.subtitle3, "description")
        XCTAssertEqual(gameCellVM.imageStringURL, "imageURL")
        
        guard let formCellsVM = section.cellsVM.filter({ cellVM in
            return cellVM is (any FormCellViewModel)
        }) as? [any FormCellViewModel] else {
            return
        }
        
        for formCellVM in formCellsVM {
            guard let formType = formCellVM.formType as? GameFormType else {
                XCTFail("Wrong type")
                return
            }
            switch formType {
            case .yearOfAcquisition:
                guard let acquisitionYearCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(acquisitionYearCellVM.placeholder, L10n.yearOfAcquisition)
            case .gameCondition(_):
                guard let gameConditionCellVM = formCellVM as? TextFieldCellViewModel,
                      let gameConditionCellVMFormType = gameConditionCellVM.formType as? GameFormType else {
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
                      let gameCompletenessCellVMFormType = gameCompletenessCellVM.formType as? GameFormType  else {
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
                      let gameRegionCellVMFormType = gameRegionCellVM.formType as? GameFormType else {
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
                guard let storageAreaCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(storageAreaCellVM.placeholder, L10n.storageArea)
            case .rating:
                guard let ratingCellVM = formCellVM as? StarRatingCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(ratingCellVM.title, L10n.personalRating)
            case .notes:
                guard let notesCellVM = formCellVM as? TextViewCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(notesCellVM.title, L10n.otherDetails)
            }
        }
    }
}
