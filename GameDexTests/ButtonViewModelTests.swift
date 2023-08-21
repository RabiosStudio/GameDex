//
//  ButtonViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import XCTest
@testable import GameDex

final class ButtonViewModelTests: XCTestCase {

    func test_init_GivenTitleAndButtonStyleBig_ThenShouldSetPropertiesCorrectly () throws {
        // Given
        let title = "Button title"
        let buttonStyle: ButtonStyle = .big
        // When
        let viewModel = ButtonViewModel(
            title: title,
            buttonStyle: buttonStyle
        )
        // Then
        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.buttonStyle, buttonStyle)
    }
    
    func test_init_GivenTitleAndButtonStyleRegular_ThenShouldSetPropertiesCorrectly () throws {
        // Given
        let title = "Button title"
        let buttonStyle: ButtonStyle = .regular
        // When
        let viewModel = ButtonViewModel(
            title: title,
            buttonStyle: buttonStyle
        )
        // Then
        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.buttonStyle, buttonStyle)
    }
    
    func test_init_GivenTitleAndButtonStyleSmall_ThenShouldSetPropertiesCorrectly () throws {
        // Given
        let title = "Button title"
        let buttonStyle: ButtonStyle = .small
        // When
        let viewModel = ButtonViewModel(
            title: title,
            buttonStyle: buttonStyle
        )
        // Then
        XCTAssertEqual(viewModel.title, title)
        XCTAssertEqual(viewModel.buttonStyle, buttonStyle)
    }
    
}
