//
//  LabelCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 01/09/2023.
//

import XCTest
@testable import GameDex

final class LabelCellViewModelTests: XCTestCase {

    func test_init_GivenCorrectParameters_ThenShouldSetPropertiesCorrectly() {
        // Given
        let text = "Title"
        let screenFactory = SelectPlatformScreenFactory()
        // When
        let cellVM = LabelCellViewModel(
            text: text,
            screenFactory: screenFactory
        )
        // Then
        XCTAssertEqual(cellVM.text, "Title")
    }
}
