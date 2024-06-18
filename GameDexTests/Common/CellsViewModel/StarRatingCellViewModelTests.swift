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
            formDelegate: FormDelegateMock()
        )
        
        // Then
        XCTAssertEqual(cellVM.title, "Title")
        XCTAssertEqual(cellVM.value, .zero)
        XCTAssertEqual(cellVM.reuseIdentifier, "\(cellVM.cellClass)")
    }
    
    func test_value_GivenValueChanged_ThenShouldCallEditFormDelegate() {
        // Given
        let delegate = FormDelegateMock()
        let cellVM = StarRatingCellViewModel(
            title: "title",
            formType: GameFormType.notes,
            value: .zero,
            formDelegate: delegate
        )
        
        // When
        cellVM.value = 1
        
        // Then
        delegate.verify(.didUpdate(value: .any, for: .any), count: .once)
    }
}
