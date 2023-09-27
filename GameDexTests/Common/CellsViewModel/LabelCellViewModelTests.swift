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
        
        let navigationStyle: NavigationStyle = .push(
            controller: SelectPlatformScreenFactory(
                delegate: GameDetailsViewModelDelegateMock()
            ).viewController
        )
        // When
        let cellVM = LabelCellViewModel(
            primaryText: primaryLabel,
            secondaryText: secondaryLabel,
            navigationStyle: navigationStyle
        )
        // Then
        XCTAssertEqual(cellVM.primaryText, "Primary label")
        XCTAssertEqual(cellVM.secondaryText, "Secondary Label")
        XCTAssertEqual(cellVM.navigationStyle, navigationStyle)
    }
}
