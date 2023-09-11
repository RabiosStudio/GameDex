//
//  AddGameDetailsSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 05/09/2023.
//

import XCTest
@testable import GameDex

final class AddGameDetailsSectionTests: XCTestCase {
    
    func test_init_GivenAddGameDetailsSection_ThenShouldSetPropertiesCorrectly() {
        // Given
        let game = Game(
            title: "The Legend of Zelda: The Minish Cap",
            description: "description",
            id: "id",
            platform: "Game Boy Advance",
            imageURL: "imageURL"
        )
        
        let section = AddGameDetailsSection(game: game)
        
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
            switch formCellVM.formType {
            case .yearOfAcquisition:
                guard let acquisitionYearCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(acquisitionYearCellVM.placeholder, L10n.yearOfAcquisition)
            case .gameCondition(_):
                guard let gameConditionCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(gameConditionCellVM.placeholder, L10n.condition)
                XCTAssertEqual(
                    gameConditionCellVM.formType,
                    .gameCondition(
                        PickerViewModel(
                            data: [GameCondition.allCases.map { $0.value }]
                        )
                    )
                )
            case .gameCompleteness(_):
                guard let gameCompletenessCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(gameCompletenessCellVM.placeholder, L10n.completeness)
                XCTAssertEqual(
                    gameCompletenessCellVM.formType,
                    .gameCompleteness(
                        PickerViewModel(
                            data: [GameCompleteness.allCases.map { $0.value }]
                        )
                    )
                )
            case .gameRegion(_):
                guard let gameRegionCellVM = formCellVM as? TextFieldCellViewModel else {
                    XCTFail("Wrong type")
                    return
                }
                XCTAssertEqual(gameRegionCellVM.placeholder, L10n.region)
                XCTAssertEqual(
                    gameRegionCellVM.formType,
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
