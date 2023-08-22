//
//  FormCollectionCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 14/08/2023.
//

import XCTest
@testable import GameDex

final class FormCellViewModelTests: XCTestCase {
    
    func test_init_GivenCorrectParameters_ThenShouldSetPropertiesCorrectly() {
        // Given
        let title = "Title"
        let shouldActiveTextField = true
        // When
        let cellVM = FormCellViewModel(
            title: title,
            shouldActiveTextField: shouldActiveTextField
        )
        // Then
        XCTAssertEqual(cellVM.title, title)
        XCTAssertTrue(cellVM.shouldActiveTextField)
    }
    
}
