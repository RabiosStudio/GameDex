//
//  ImageDescriptionCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 06/09/2023.
//

import XCTest
@testable import GameDex

final class ImageDescriptionCellViewModelTests: XCTestCase {
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let imageStringURL = "Image URL"
        let title = "Title"
        let subtitle1 = "Subtitle 1"
        let subtitle2 = "Subtitle 2"
        let subtitle3 = "Subtitle 3"
        
        // When
        let cellVM = ImageDescriptionCellViewModel(
            imageStringURL: imageStringURL,
            title: title,
            subtitle1: subtitle1,
            subtitle2: subtitle2,
            subtitle3: subtitle3
        )
        
        // Then
        XCTAssertEqual(cellVM.title, "Title")
        XCTAssertEqual(cellVM.imageStringURL, "Image URL")
        XCTAssertEqual(cellVM.subtitle1, "Subtitle 1")
        XCTAssertEqual(cellVM.subtitle2, "Subtitle 2")
        XCTAssertEqual(cellVM.subtitle3, "Subtitle 3")
        XCTAssertEqual(cellVM.reuseIdentifier, "\(cellVM.cellClass)")
    }
}
