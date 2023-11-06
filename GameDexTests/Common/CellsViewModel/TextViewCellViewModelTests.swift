//
//  TextViewCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 06/09/2023.
//

import XCTest
@testable import GameDex

final class TextViewCellViewModelTests: XCTestCase {
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let title = "Title"
        let text = "Text"
        
        // When
        let cellVM = TextViewCellViewModel(
            title: title,
            formType: GameFormType.notes,
            value: text,
            editDelegate: EditFormDelegateMock()
        )
        
        // Then
        XCTAssertEqual(cellVM.title, "Title")
        XCTAssertEqual(cellVM.value, "Text")
        XCTAssertEqual(cellVM.reuseIdentifier, "\(cellVM.cellClass)")
    }
    
    func test_value_GivenValueChanged_ThenShouldCallEditFormDelegate() {
        // Given
        let delegate = EditFormDelegateMock()
        let cellVM = TextViewCellViewModel(
            title: "title",
            formType: GameFormType.notes,
            value: "text",
            editDelegate: delegate
        )
        
        // When
        cellVM.value = "updated text"
        
        // Then
        delegate.verify(.enableSaveButtonIfNeeded())
    }
}
