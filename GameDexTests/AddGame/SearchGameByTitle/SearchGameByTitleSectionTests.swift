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
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, MockData.games.count)
        
        guard let game1CellVM = section.cellsVM.first as? BasicInfoCellViewModel,
              let game2CellVM = section.cellsVM.last as? BasicInfoCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(game1CellVM.title, "Title")
        XCTAssertEqual(game1CellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(game1CellVM.subtitle2, MockData.games[0].formattedReleaseDate)
        XCTAssertEqual(game1CellVM.caption, "imageURL")
        
        XCTAssertEqual(game2CellVM.title, "Title")
        XCTAssertEqual(game2CellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(game1CellVM.subtitle2, MockData.games[1].formattedReleaseDate)
        XCTAssertEqual(game2CellVM.caption, "imageURL")
    }
    
    func test_cellTappedCallback_ThenLastNavigationStyleIsCorrect() {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let section = SearchGameByTitleSection(
            gamesQuery: MockData.games,
            platform: MockData.platform,
            myCollectionDelegate: myCollectionDelegate
        )
        
        for (index, cellVM) in section.cellsVM.enumerated() {
            
            // When
            cellVM.cellTappedCallback?()
            
            // Then
            let expectedNavigationStyle: NavigationStyle = .push(
                screenFactory: AddGameDetailsScreenFactory(
                    game: MockData.games[index],
                    platform: MockData.platform,
                    myCollectionDelegate: myCollectionDelegate
                )
            )
            
            XCTAssertEqual(Routing.shared.lastNavigationStyle, expectedNavigationStyle)
        }
    }
}
