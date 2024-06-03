//
//  TextFieldCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 14/08/2023.
//

import XCTest
@testable import GameDex

final class TextFieldCellViewModelTests: XCTestCase {
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let placeholder = "Some placeholder"
        let text = "Some text"
        
        // When
        let cellVM = TextFieldCellViewModel(
            placeholder: placeholder,
            formType: GameFormType.storageArea,
            value: text,
            formDelegate: FormDelegateMock()
        )
        // Then
        XCTAssertEqual(cellVM.placeholder, "Some placeholder")
        XCTAssertEqual(cellVM.value, "Some text")
        XCTAssertEqual(cellVM.reuseIdentifier, "\(cellVM.cellClass)")
    }
}
