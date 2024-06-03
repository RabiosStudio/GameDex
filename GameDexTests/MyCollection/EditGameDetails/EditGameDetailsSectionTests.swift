//
//  EditGameDetailsSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 17/09/2023.
//

import XCTest
@testable import GameDex

final class EditGameDetailsSectionTests: XCTestCase {

    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = EditGameDetailsSection(
            savedGame: MockData.savedGame,
            platformName: MockData.platform.title,
            gameForm: MockData.gameForm,
            formDelegate: FormDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 9)
        
        guard let gameCellVM = section.cellsVM.first as? ImageDescriptionCellViewModel else {
            XCTFail("Wrong type")
            return
        }
        
        XCTAssertEqual(gameCellVM.title, "Title")
        XCTAssertEqual(gameCellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(gameCellVM.subtitle2, MockData.savedGame.game.formattedReleaseDate)
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
            case .acquisitionYear:
                guard let acquisitionYearCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(acquisitionYearCellVM.placeholder, L10n.yearOfAcquisition)
                XCTAssertEqual(acquisitionYearCellVM.value, MockData.savedGame.acquisitionYear)
            case .gameCondition(_):
                guard let gameConditionCellVM = formCellVM as? TextFieldCellViewModel,
                      let gameConditionCellVMFormType = gameConditionCellVM.formType as? GameFormType else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(gameConditionCellVM.placeholder, L10n.condition)
                XCTAssertEqual(gameConditionCellVM.value, MockData.savedGame.gameCondition?.value)
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
                XCTAssertEqual(gameCompletenessCellVM.value, MockData.savedGame.gameCompleteness?.value)
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
                XCTAssertEqual(gameRegionCellVM.value, MockData.savedGame.gameRegion?.value)
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
                XCTAssertEqual(storageAreaCellVM.value, MockData.savedGame.storageArea)
            case .rating:
                guard let ratingCellVM = formCellVM as? StarRatingCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(ratingCellVM.title, L10n.personalRating)
                XCTAssertEqual(ratingCellVM.value, MockData.savedGame.rating)
            case .notes:
                guard let notesCellVM = formCellVM as? TextViewCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(notesCellVM.title, L10n.otherDetails)
                XCTAssertEqual(notesCellVM.value, MockData.savedGame.notes)
            case .isPhysical:
                guard let isPhysicalCellVM = formCellVM as? SegmentedControlCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(isPhysicalCellVM.value, MockData.savedGame.isPhysical ? L10n.physical : L10n.digital)
            }
        }
    }
}
