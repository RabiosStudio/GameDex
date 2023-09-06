//
//  ImageDescriptionCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 06/09/2023.
//

import XCTest
@testable import GameDex

final class ImageDescriptionCellViewModelTests: XCTestCase {
    func test_init_GivenCorrectParameters_ThenShouldSetPropertiesCorrectly() {
        // Given
        let imageStringURL = "Image URL"
        let title = "Title"
        let subtitle1 = "Subtitle 1"
        let subtitle2 = "Subtitle 2"
        
        // When
        let cellVM = ImageDescriptionCellViewModel(
            imageStringURL: imageStringURL,
            title: title,
            subtitle1: subtitle1,
            subtitle2: subtitle2
        )
        
        // Then
        XCTAssertEqual(cellVM.title, "Title")
        XCTAssertEqual(cellVM.imageStringURL, "Image URL")
        XCTAssertEqual(cellVM.subtitle1, "Subtitle 1")
        XCTAssertEqual(cellVM.subtitle2, "Subtitle 2")
    }
}
