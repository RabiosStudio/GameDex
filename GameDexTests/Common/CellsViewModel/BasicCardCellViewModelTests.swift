//
//  BasicCardCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 01/09/2023.
//

import XCTest
@testable import GameDex

final class BasicCardCellViewModelTests: XCTestCase {

    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let text = "Title"
        let description = "Description"
        let screenFactory = SelectPlatformScreenFactory(delegate: GameDetailsViewModelDelegateMock())
        // When
        let cellVM = BasicCardCellViewModel(
            cardType: SelectAddGameMethodCardType.manually,
            title: text,
            description: description,
            screenFactory: screenFactory
        )
        // Then
        XCTAssertEqual(cellVM.cardTitle, "Title")
        XCTAssertEqual(cellVM.cardDescription, "Description")
        
        let expectedNavigationStyle: NavigationStyle = {
            return .push(
                controller: screenFactory.viewController
            )
        }()
        XCTAssertEqual(cellVM.navigationStyle, expectedNavigationStyle)
    }
}
