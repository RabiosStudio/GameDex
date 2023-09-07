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
        
        guard let gameCellVM = section.cellsVM.first as? ImageDescriptionCellViewModel,
              let yearOfAcquisitionCellVM = section.cellsVM[1] as? TextFieldCellViewModel,
              let conditionCellVM = section.cellsVM[2] as? TextFieldCellViewModel,
              let completenessCellVM = section.cellsVM[3] as? TextFieldCellViewModel,
              let regionCellVM = section.cellsVM[4] as? TextFieldCellViewModel,
              let storageAreaCellVM = section.cellsVM[5] as? TextFieldCellViewModel,
              let personalRatingCellVM = section.cellsVM[6] as? StarRatingCellViewModel,
              let otherDetailsCellVM = section.cellsVM.last as? TextViewCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(gameCellVM.title, "The Legend of Zelda: The Minish Cap")
        XCTAssertEqual(gameCellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(gameCellVM.subtitle2, "description")
        XCTAssertEqual(gameCellVM.imageStringURL, "imageURL")
        
        XCTAssertEqual(yearOfAcquisitionCellVM.placeholder, L10n.yearOfAcquisition)
        XCTAssertEqual(yearOfAcquisitionCellVM.textFieldType, .year)
        
        XCTAssertEqual(conditionCellVM.placeholder, L10n.condition)
        XCTAssertEqual(
            conditionCellVM.textFieldType,
            .picker(
                PickerViewModel(
                    data: GameCondition.allCases.map { $0.value }
                )
            )
        )
        
        XCTAssertEqual(completenessCellVM.placeholder, L10n.completeness)
        XCTAssertEqual(
            conditionCellVM.textFieldType,
            .picker(
                PickerViewModel(
                    data: GameCompleteness.allCases.map { $0.value }
                )
            )
        )
        
        XCTAssertEqual(regionCellVM.placeholder, L10n.region)
        XCTAssertEqual(
            conditionCellVM.textFieldType,
            .picker(
                PickerViewModel(
                    data: GameRegion.allCases.map { $0.rawValue }
                )
            )
        )
        
        XCTAssertEqual(storageAreaCellVM.placeholder, L10n.storageArea)
        XCTAssertEqual(storageAreaCellVM.textFieldType, .text)
        
        XCTAssertEqual(personalRatingCellVM.title, L10n.personalRating)
        XCTAssertEqual(personalRatingCellVM.rating, .zero)
        
        XCTAssertEqual(otherDetailsCellVM.title, L10n.otherDetails)
    }
}
