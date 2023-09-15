//
//  MyCollectionViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 22/08/2023.
//

import XCTest
@testable import GameDex

final class MyCollectionViewModelTests: XCTestCase {
    
    func test_loadData_GivenEmptyCollection_ThenCallbackShouldReturnNoItems() {
        // Given
        let viewModel = MyCollectionViewModel(
            localDatabase: LocalDatabase(),
            alertDisplayer: AlertDisplayerMock()
        )
        // When
        viewModel.loadData { error in
            // Then
            guard let error = error as? MyCollectionError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, MyCollectionError.noItems)
        }
    }
    
    func test_numberOfSections_ThenShouldReturnZero() {
        // Given
        let viewModel = MyCollectionViewModel(
            localDatabase: LocalDatabase(),
            alertDisplayer: AlertDisplayerMock()
        )
        // When
        let numberOfSections = viewModel.numberOfSections()
        // Then
        XCTAssertEqual(numberOfSections, .zero)
    }
    
    func test_numberOfItems_ThenShouldReturnZero() {
        // Given
        let viewModel = MyCollectionViewModel(
            localDatabase: LocalDatabase(),
            alertDisplayer: AlertDisplayerMock()
        )
        // When
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        // Then
        XCTAssertEqual(numberOfItems, .zero)
    }
}
