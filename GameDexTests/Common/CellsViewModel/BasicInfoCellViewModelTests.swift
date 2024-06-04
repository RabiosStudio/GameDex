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
        let icon = GameFormat.physical.image
        let subtitle2 = "Subtitle 2"
        let captionName = "Caption Name"
        
        // When
        let cellVM = BasicInfoCellViewModel(
            title: text,
            subtitle1: subtitle1,
            subtitle2: subtitle2,
            caption: captionName,
            icon: icon
        )
        // Then
        XCTAssertEqual(cellVM.title, "Title")
        XCTAssertEqual(cellVM.icon, icon)
        XCTAssertEqual(cellVM.subtitle1, "Subtitle 1")
        XCTAssertEqual(cellVM.subtitle2, "Subtitle 2")
        XCTAssertEqual(cellVM.caption, "Caption Name")
        XCTAssertEqual(cellVM.reuseIdentifier, "\(cellVM.cellClass)")
    }
}
