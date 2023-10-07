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
        let section = SelectAddGameMethodSection(delegate: MyCollectionViewModelDelegateMock())
        
        // Then
        XCTAssertEqual(section.cellsVM.count, 2)
        
        guard let manualCellVM = section.cellsVM.first as? BasicCardCellViewModel,
              let scanCellVM = section.cellsVM.last as? BasicCardCellViewModel else {
            XCTFail("Cell View Models are not correct")
            return
        }
        
        XCTAssertEqual(manualCellVM.cardTitle, L10n.manually)
        XCTAssertEqual(manualCellVM.cardDescription, L10n.manuallyDescription)
        XCTAssertEqual(scanCellVM.cardTitle, L10n.scan)
        XCTAssertEqual(scanCellVM.cardDescription, L10n.comingSoon)
    }
    
    func test_cellTappedCallback_ThenLastNavigationStyleIsCorrect() {
        // Given
        let delegate = MyCollectionViewModelDelegateMock()
        let section = SelectAddGameMethodSection(delegate: delegate)
        
        // When
        section.cellsVM.first?.cellTappedCallback?()
        
        // Then
        let expectedNavigationStyle: NavigationStyle = .push(
            screenFactory: SelectPlatformScreenFactory(
                delegate: delegate
            )
        )
        
        XCTAssertEqual(Routing.shared.lastNavigationStyle, expectedNavigationStyle)
    }
}
