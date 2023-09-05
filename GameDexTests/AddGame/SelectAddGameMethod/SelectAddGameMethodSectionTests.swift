//
//  SelectAddGameMethodSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 27/08/2023.
//

import XCTest
@testable import GameDex

final class SelectAddGameMethodSectionTests: XCTestCase {

    func test_init_GivenSelectAddGameMethodSection_ThenShouldSetPropertiesCorrectly() {
        // Given
        
        // When
        let section = SelectAddGameMethodSection()
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 2)
        
        guard let manualCellVM = section.cellsVM.first as? InfoCardCellViewModel,
              let scanCellVM = section.cellsVM.last as? InfoCardCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(manualCellVM.title, L10n.manually)
        XCTAssertEqual(manualCellVM.description, L10n.manuallyDescription)
        XCTAssertEqual(manualCellVM.imageName, Asset.form.name)
        XCTAssertEqual(scanCellVM.title, L10n.scan)
        XCTAssertEqual(scanCellVM.description, L10n.comingSoon)
        XCTAssertEqual(scanCellVM.imageName, Asset.barcode.name)
    }
}
