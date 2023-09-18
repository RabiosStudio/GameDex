//
//  SearchGameByTitleSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import XCTest
@testable import GameDex

final class SearchGameByTitleSectionTests: XCTestCase {
    
    func test_init_GivenSearchGameByTitleSection_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = SearchGameByTitleSection(
            gamesQuery: MockData.games,
            platform: MockData.platform,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, MockData.games.count)
        
        guard let game1CellVM = section.cellsVM.first as? BasicInfoCellViewModel,
              let game2CellVM = section.cellsVM.last as? BasicInfoCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(game1CellVM.title, "The Legend of Zelda: The Minish Cap")
        XCTAssertEqual(game1CellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(game1CellVM.subtitle2, "description")
        XCTAssertEqual(game1CellVM.caption, "imageURL")
        
        XCTAssertEqual(game2CellVM.title, "The Legend of Zelda: A link to the past")
        XCTAssertEqual(game2CellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(game2CellVM.subtitle2, "description")
        XCTAssertEqual(game2CellVM.caption, "imageURL")
    }
}
