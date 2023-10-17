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
        
        // When
        let cellVM = LabelCellViewModel(text: primaryLabel)
        // Then
        XCTAssertEqual(cellVM.text, "Primary label")
    }
}
