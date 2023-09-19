//
//  MyCollectionByPlatformSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 17/09/2023.
//

import XCTest
@testable import GameDex

final class MyCollectionByPlatformSectionTests: XCTestCase {

    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = MyCollectionByPlatformsSection(
            gamesCollection: MockData.savedGames,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, MockData.savedGames.count)
        
        guard let game1CellVM = section.cellsVM.first as? BasicInfoCellViewModel,
              let game2CellVM = section.cellsVM.last as? BasicInfoCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(game1CellVM.title, "The Legend of Zelda: A link to the past")
        XCTAssertEqual(game1CellVM.subtitle1, nil)
        XCTAssertEqual(game1CellVM.subtitle2, Date.now.convertToString())
        XCTAssertEqual(game1CellVM.caption, "imageURL")
        
        XCTAssertEqual(game2CellVM.title, "The Legend of Zelda: The Minish Cap")
        XCTAssertEqual(game2CellVM.subtitle1, nil)
        XCTAssertEqual(game1CellVM.subtitle2, Date.now.convertToString())
        XCTAssertEqual(game2CellVM.caption, "imageURL")
    }
}
