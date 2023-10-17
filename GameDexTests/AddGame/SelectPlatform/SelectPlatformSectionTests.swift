//
//  SelectPlatformSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import XCTest
@testable import GameDex

final class SelectPlatformSectionTests: XCTestCase {

    func test_init_GivenSelectPlatformSection_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = SelectPlatformSection(
            platforms: MockData.platforms,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(section.cellsVM.count, MockData.platforms.count)
        
        for (index, platform) in MockData.platforms.enumerated() {
            guard let collectionCellVM = section.cellsVM[index] as? BasicInfoCellViewModel else {
                XCTFail("Cell View Models are not correct")
                return
            }
            
            let gameArrayByPlatform = platform.games
            guard let gameArray = gameArrayByPlatform else { return }
                        
            XCTAssertEqual(collectionCellVM.title, platform.title)
            XCTAssertEqual(collectionCellVM.subtitle1, nil)
            XCTAssertEqual(collectionCellVM.subtitle2, nil)
            XCTAssertEqual(collectionCellVM.caption, platform.imageUrl)
        }
    }
    
    func test_cellTappedCallback_ThenLastNavigationStyleIsCorrect() {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let section = SelectPlatformSection(
            platforms: MockData.platforms,
            myCollectionDelegate: myCollectionDelegate
        )
        
        for (index, cellVM) in section.cellsVM.enumerated() {
            
            // When
            cellVM.cellTappedCallback?()
            
            // Then
            let expectedNavigationStyle: NavigationStyle = .push(
                screenFactory: SearchGameByTitleScreenFactory(
                    platform: MockData.platforms[index],
                    myCollectionDelegate: myCollectionDelegate
                )
            )
            
            XCTAssertEqual(Routing.shared.lastNavigationStyle, expectedNavigationStyle)
        }
    }
}
