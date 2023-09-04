//
//  SelectPlatformSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import XCTest
@testable import GameDex

final class SelectPlatformSectionTests: XCTestCase {

    func test_init_GivenSelectPlatformSection_ThenShouldSetPropertiesCorrectly() {
        // Given
        let platforms: [Platform] = [
            Platform(title: "Atari 2600", id: 28),
            Platform(title: "Dreamcast", id: 8),
            Platform(title: "Game Boy Color", id: 11),
            Platform(title: "Jaguar", id: 17),
            Platform(title: "SNES", id: 15)
        ]
        
        // When
        let section = SelectPlatformSection(platforms: platforms)
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 5)
        
        guard let platform1CellVM = section.cellsVM.first as? LabelCellViewModel,
              let platform2CellVM = section.cellsVM[1] as? LabelCellViewModel,
              let platform3CellVM = section.cellsVM[2] as? LabelCellViewModel,
              let platform4CellVM = section.cellsVM[3] as? LabelCellViewModel,
              let platform5CellVM = section.cellsVM.last as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(platform1CellVM.text, "Atari 2600")
        XCTAssertEqual(platform2CellVM.text, "Dreamcast")
        XCTAssertEqual(platform3CellVM.text, "Game Boy Color")
        XCTAssertEqual(platform4CellVM.text, "Jaguar")
        XCTAssertEqual(platform5CellVM.text, "SNES")
    }
}