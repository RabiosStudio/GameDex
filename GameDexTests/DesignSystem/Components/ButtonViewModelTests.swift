//
//  ButtonViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import XCTest
@testable import GameDex

final class ButtonViewModelTests: XCTestCase {

    func test_init_GivenTitle_ThenShouldSetPropertiesCorrectly() {
        // Given
        let title = "Button title"
        // When
        let viewModel = ButtonViewModel(buttonTitle: title, buttonBackgroundColor: .secondaryColor)
        // Then
        XCTAssertEqual(viewModel.buttonTitle, title)
        XCTAssertTrue(viewModel.isEnabled)
    }
}
