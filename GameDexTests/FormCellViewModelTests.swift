//
//  FormCollectionCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 14/08/2023.
//

import XCTest
@testable import GameDex

final class FormCellViewModelTests: XCTestCase {
    
    func test_init_GivenTitleAndActiveTextField_ThenShouldSetPropertiesCorrectly () throws {
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
    
    func test_init_GivenTitleAndInActiveTextField_ThenShouldSetPropertiesCorrectly () throws {
        // Given
        let title = "Title"
        let shouldActiveTextField = false
        // When
        let cellVM = FormCellViewModel(
            title: title,
            shouldActiveTextField: shouldActiveTextField
        )
        // Then
        XCTAssertEqual(cellVM.title, title)
        XCTAssertFalse(cellVM.shouldActiveTextField)
    }
    
}
