//
//  MyProfileSectionTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 23/09/2023.
//

import XCTest
@testable import GameDex

final class MyProfileSectionTests: XCTestCase {
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let section = MyProfileSection()
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 3)
        
        guard let loginCellVM = section.cellsVM.first as? LabelCellViewModel,
              let collectionManagementCellVM = section.cellsVM[1] as? LabelCellViewModel,
              let contactUsCellVM = section.cellsVM.last as? LabelCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(loginCellVM.primaryText, L10n.login)
        XCTAssertEqual(loginCellVM.secondaryText, nil)
        XCTAssertEqual(collectionManagementCellVM.primaryText, L10n.collectionManagement)
        XCTAssertEqual(collectionManagementCellVM.secondaryText, nil)
        XCTAssertEqual(contactUsCellVM.primaryText, L10n.contactUs)
        XCTAssertEqual(contactUsCellVM.secondaryText, nil)
    }
}
