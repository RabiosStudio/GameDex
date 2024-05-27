//
//  PrimaryButtonCellViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 05/11/2023.
//

import XCTest
@testable import GameDex

final class PrimaryButtonCellViewModelTests: XCTestCase {
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let title = "Title"
        
        // When
        let cellVM = PrimaryButtonCellViewModel(
            buttonViewModel: ButtonViewModel(title: title, backgroundColor: .secondaryColor),
            delegate: PrimaryButtonDelegateMock()
        )
        // Then
        let expectedButtonVM = ButtonViewModel(title: title, backgroundColor: .secondaryColor)
        XCTAssertEqual(cellVM.buttonViewModel, expectedButtonVM)
        XCTAssertEqual(cellVM.reuseIdentifier, "\(cellVM.cellClass)")
    }
    
    func test_didTap_ThenShouldCallDelegate() {
        // Given
        let delegate = PrimaryButtonDelegateMock()
        let viewModel = PrimaryButtonCellViewModel(buttonViewModel: ButtonViewModel(title: "title", backgroundColor: .secondaryColor), delegate: delegate)
        
        // When
        viewModel.didTap(buttonTitle: "title") {
            delegate.verify(.didTapPrimaryButton(with: "title"), count: .once)
        }
    }
}
