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
        let section = MyCollectionSection(
            platforms: MockData.platforms,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, MockData.platforms.count)
        
        let sortedPlatforms = MockData.platforms.sorted {
            $0.title < $1.title
        }
        
        for (index, platform) in sortedPlatforms.enumerated() {
            guard let collectionCellVM = section.cellsVM[index] as? BasicInfoCellViewModel else {
                XCTFail("Cell View Models are not correct")
                return
            }
            
            let gameArrayByPlatform = platform.games
            guard let gameArray = gameArrayByPlatform else { return }
            let text = gameArray.count > 1 ? L10n.games : L10n.game
            
            let expectedSubtitle = "\(String(describing: gameArray.count)) \(text)"
            
            XCTAssertEqual(collectionCellVM.title, platform.title)
            XCTAssertEqual(collectionCellVM.subtitle1, expectedSubtitle)
            XCTAssertEqual(collectionCellVM.subtitle2, nil)
            XCTAssertEqual(collectionCellVM.caption, platform.imageUrl)
        }
    }
    
    func test_cellTappedCallback_ThenLastNavigationStyleIsCorrect() {
        // Given
        let platforms = MockData.platforms
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let section = MyCollectionSection(
            platforms: platforms,
            myCollectionDelegate: myCollectionDelegate
        )
        
        for (index, cellVM) in section.cellsVM.enumerated() {
            
            // When
            cellVM.cellTappedCallback?()
            
            // Then
            let expectedNavigationStyle: NavigationStyle = .push(
                screenFactory: MyCollectionByPlatformsScreenFactory(
                    platform: platforms[index],
                    myCollectionDelegate: myCollectionDelegate
                )
            )
            XCTAssertEqual(Routing.shared.lastNavigationStyle, expectedNavigationStyle)
        }
    }
}
