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
            games: MockData.savedGames,
            platform: MockData.platform,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, MockData.savedGames.count)
        
        guard let game1CellVM = section.cellsVM.first as? BasicInfoCellViewModel,
              let game2CellVM = section.cellsVM.last as? BasicInfoCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(game1CellVM.title, "Title")
        XCTAssertEqual(game1CellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(game1CellVM.subtitle2, MockData.savedGames[0].game.formattedReleaseDate)
        XCTAssertEqual(game1CellVM.caption, "imageURL")
        
        XCTAssertEqual(game2CellVM.title, "Title")
        XCTAssertEqual(game2CellVM.subtitle1, "Game Boy Advance")
        XCTAssertEqual(game1CellVM.subtitle2, MockData.savedGames[1].game.formattedReleaseDate)
        XCTAssertEqual(game2CellVM.caption, "imageURL")
    }
    
    func test_cellTappedCallback_ThenLastNavigationStyleIsCorrect() {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        
        let section = MyCollectionByPlatformsSection(
            games: MockData.savedGames,
            platform: MockData.platform,
            myCollectionDelegate: myCollectionDelegate
        )
        
        for (index, cellVM) in section.cellsVM.enumerated() {
            
            // When
            cellVM.cellTappedCallback?()
            
            // Then
            let expectedNavigationStyle: NavigationStyle = .push(
                screenFactory: EditGameDetailsScreenFactory(
                    savedGame: MockData.savedGames[index],
                    platform: MockData.platform,
                    myCollectionDelegate: myCollectionDelegate
                )
            )
            
            XCTAssertEqual(Routing.shared.lastNavigationStyle, expectedNavigationStyle)
        }
    }
}
