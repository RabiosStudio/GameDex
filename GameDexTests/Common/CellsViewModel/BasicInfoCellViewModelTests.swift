//
//  BasicInfoCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 01/09/2023.
//

import XCTest
@testable import GameDex

final class BasicInfoCellViewModelTests: XCTestCase {
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let text = "Title"
        let subtitle1 = "Subtitle 1"
        let subtitle2 = "Subtitle 2"
        let captionName = "Caption Name"
        let screenFactory = SelectPlatformScreenFactory(delegate: AddGameDetailsViewModelDelegateMock())
        // When
        let cellVM = BasicInfoCellViewModel(
            title: text,
            subtitle1: subtitle1,
            subtitle2: subtitle2,
            caption: captionName,
            screenFactory: screenFactory
        )
        // Then
        XCTAssertEqual(cellVM.title, "Title")
        XCTAssertEqual(cellVM.subtitle1, "Subtitle 1")
        XCTAssertEqual(cellVM.subtitle2, "Subtitle 2")
        XCTAssertEqual(cellVM.caption, "Caption Name")
        
        let expectedNavigationStyle: NavigationStyle = {
            return .push(
                controller: screenFactory.viewController
            )
        }()
        XCTAssertEqual(cellVM.navigationStyle, expectedNavigationStyle)
    }
}
