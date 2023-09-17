//
//  MyCollectionSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 16/09/2023.
//

import XCTest
@testable import GameDex

final class MyCollectionSectionTests: XCTestCase {
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = MyCollectionSection(gamesCollection: MockData.savedGames)
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 1)
        
        guard let collectionCellVM = section.cellsVM.first as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(collectionCellVM.mainText, "Game Boy Advance")
        XCTAssertEqual(collectionCellVM.optionalText, "2 \(L10n.games)")
    }
}
