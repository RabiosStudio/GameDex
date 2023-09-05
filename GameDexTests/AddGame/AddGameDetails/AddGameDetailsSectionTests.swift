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
            image: "imageURL"
        )
        
        let section = AddGameDetailsSection(game: game)
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 7)
        
        guard let gameCellVM = section.cellsVM.first as? ImageDescriptionCellViewModel,
              let yearOfAcquisitionCellVM = section.cellsVM[1] as? TextFieldCellViewModel,
              let purchasePriceCellVM = section.cellsVM[2] as? TextFieldCellViewModel,
              let conditionCellVM = section.cellsVM[3] as? TextFieldCellViewModel,
              let storageAreaCellVM = section.cellsVM[4] as? TextFieldCellViewModel,
              let personalRatingCellVM = section.cellsVM[5] as? StarRatingCellViewModel,
              let otherDetailsCellVM = section.cellsVM.last as? TextViewCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(gameCellVM.title, "The Legend of Zelda: The Minish Cap")
        XCTAssertEqual(gameCellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(gameCellVM.subtitle2, "description")
        XCTAssertEqual(gameCellVM.imageStringURL, "imageURL")
        
        XCTAssertEqual(yearOfAcquisitionCellVM.title, L10n.yearOfAcquisition)
        XCTAssertEqual(yearOfAcquisitionCellVM.textFieldType, .numbers)
        XCTAssertTrue(yearOfAcquisitionCellVM.shouldActiveTextField)
        
        XCTAssertEqual(purchasePriceCellVM.title, L10n.purchasePrice)
        XCTAssertEqual(purchasePriceCellVM.textFieldType, .numbers)
        XCTAssertFalse(purchasePriceCellVM.shouldActiveTextField)
        
        XCTAssertEqual(conditionCellVM.title, L10n.condition)
        XCTAssertEqual(conditionCellVM.textFieldType, .text)
        XCTAssertFalse(conditionCellVM.shouldActiveTextField)
        
        XCTAssertEqual(storageAreaCellVM.title, L10n.storageArea)
        XCTAssertEqual(storageAreaCellVM.textFieldType, .text)
        XCTAssertFalse(storageAreaCellVM.shouldActiveTextField)
        
        XCTAssertEqual(personalRatingCellVM.title, L10n.personalRating)
        XCTAssertEqual(personalRatingCellVM.rating, .zero)
        
        XCTAssertEqual(otherDetailsCellVM.title, L10n.otherDetails)
    }
}
