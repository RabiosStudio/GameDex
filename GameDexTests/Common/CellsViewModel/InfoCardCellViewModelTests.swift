//
//  InfoCardCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 01/09/2023.
//

import XCTest
@testable import GameDex

final class InfoCardCellViewModelTests: XCTestCase {

    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let text = "Title"
        let description = "Description"
        let imageName = "ImageName"
        let screenFactory = SelectPlatformScreenFactory(delegate: AddGameDetailsViewModelDelegateMock())
        // When
        let cellVM = InfoCardCellViewModel(
            title: text,
            description: description,
            imageName: imageName,
            screenFactory: screenFactory
        )
        // Then
        XCTAssertEqual(cellVM.title, "Title")
        XCTAssertEqual(cellVM.description, "Description")
        XCTAssertEqual(cellVM.imageName, "ImageName")
        
        let expectedNavigationStyle: NavigationStyle = {
            return .push(
                controller: screenFactory.viewController
            )
        }()
        XCTAssertEqual(cellVM.navigationStyle, expectedNavigationStyle)
    }
}
