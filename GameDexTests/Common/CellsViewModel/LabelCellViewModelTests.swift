//
//  LabelCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 01/09/2023.
//

import XCTest
@testable import GameDex

final class LabelCellViewModelTests: XCTestCase {

    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let primaryLabel = "Primary label"
        let secondaryLabel = "Secondary Label"
        
        let screenFactory = SelectPlatformScreenFactory(delegate: GameDetailsViewModelDelegateMock())
        // When
        let cellVM = LabelCellViewModel(
            mainText: primaryLabel,
            optionalText: secondaryLabel,
            screenFactory: screenFactory
        )
        // Then
        XCTAssertEqual(cellVM.mainText, "Primary label")
        XCTAssertEqual(cellVM.optionalText, "Secondary Label")
        
        let expectedNavigationStyle: NavigationStyle = {
            return .push(
                controller: screenFactory.viewController
            )
        }()
        XCTAssertEqual(cellVM.navigationStyle, expectedNavigationStyle)
    }
}
