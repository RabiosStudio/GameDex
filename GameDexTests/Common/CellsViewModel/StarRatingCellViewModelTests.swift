//
//  StarRatingCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 06/09/2023.
//

import XCTest
@testable import GameDex

final class StarRatingCellViewModelTests: XCTestCase {
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let title = "Title"
        
        // When
        let cellVM = StarRatingCellViewModel(
            title: title,
            formType: GameFormType.rating,
            value: .zero,
            editDelegate: EditFormDelegateMock()
        )
        
        // Then
        XCTAssertEqual(cellVM.title, "Title")
        XCTAssertEqual(cellVM.value, .zero)
    }
}
