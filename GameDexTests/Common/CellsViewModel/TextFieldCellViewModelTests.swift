//
//  TextFieldCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 14/08/2023.
//

import XCTest
@testable import GameDex

final class TextFieldCellViewModelTests: XCTestCase {
    
    func test_init_GivenCorrectParameters_ThenShouldSetPropertiesCorrectly() {
        // Given
        let title = "Title"
        let shouldActiveTextField = true
        // When
        let cellVM = TextFieldCellViewModel(
            title: title,
            shouldActiveTextField: shouldActiveTextField
        )
        // Then
        XCTAssertEqual(cellVM.title, "Title")
        XCTAssertTrue(cellVM.shouldActiveTextField)
    }
    
}
