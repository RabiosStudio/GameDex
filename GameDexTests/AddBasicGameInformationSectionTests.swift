//
//  AddBasicGameInformationSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import XCTest
@testable import GameDex

final class AddBasicGameInformationSectionTests: XCTestCase {
    
    func test_init_GivenAddBasicGameInformationSection_ThenShouldSetPropertiesCorrectly () throws {
        // Given
        
        // When
        let section = AddBasicGameInformationSection()
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 3)
        
        guard let descriptionCellVM = section.cellsVM.first as? LabelCellViewModel,
              let gameTitleCellVM = section.cellsVM[1] as? FormCellViewModel,
              let platformCellVM = section.cellsVM.last as? FormCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(descriptionCellVM.text, L10n.addBasicGameInformationDescription)
        XCTAssertEqual(gameTitleCellVM.title, L10n.title)
        XCTAssertTrue(gameTitleCellVM.shouldActiveTextField)
        XCTAssertEqual(platformCellVM.title, L10n.platform)
        XCTAssertFalse(platformCellVM.shouldActiveTextField)
    }
}
