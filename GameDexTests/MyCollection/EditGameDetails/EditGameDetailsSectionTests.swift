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
            editDelegate: EditFormDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 8)
        
        guard let gameCellVM = section.cellsVM.first as? ImageDescriptionCellViewModel else {
            XCTFail("Wrong type")
            return
        }
        
        XCTAssertEqual(gameCellVM.title, "The Legend of Zelda: The Minish Cap")
        XCTAssertEqual(gameCellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(gameCellVM.subtitle2, "description")
        XCTAssertEqual(gameCellVM.imageStringURL, "imageURL")
        
        guard let formCellsVM = section.cellsVM.filter({ cellVM in
            return cellVM is (any CollectionFormCellViewModel)
        }) as? [any CollectionFormCellViewModel] else {
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
                XCTAssertEqual(acquisitionYearCellVM.value, MockData.savedGame.acquisitionYear)
            case .gameCondition(_):
                guard let gameConditionCellVM = formCellVM as? TextFieldCellViewModel,
                      let gameConditionCellVMFormType = gameConditionCellVM.formType as? GameFormType else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(gameConditionCellVM.placeholder, L10n.condition)
                XCTAssertEqual(gameConditionCellVM.value, MockData.savedGame.gameCondition)
                XCTAssertEqual(
                    gameConditionCellVMFormType,
                    .gameCondition(
                        PickerViewModel(
                            data: [GameCondition.allCases.map { $0.value }]
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
                XCTAssertEqual(gameCompletenessCellVM.value, MockData.savedGame.gameCompleteness)
                XCTAssertEqual(
                    gameCompletenessCellVMFormType,
                    .gameCompleteness(
                        PickerViewModel(
                            data: [GameCompleteness.allCases.map { $0.value }]
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
                XCTAssertEqual(gameRegionCellVM.value, MockData.savedGame.gameRegion)
                XCTAssertEqual(
                    gameRegionCellVMFormType,
                    .gameRegion(
                        PickerViewModel(
                            data: [GameRegion.allCases.map { $0.rawValue }]
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
            }
        }
    }
}
