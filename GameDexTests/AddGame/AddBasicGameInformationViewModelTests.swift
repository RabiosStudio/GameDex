//
//  AddBasicGameInformationViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 21/08/2023.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class AddBasicGameInformationViewModelTests: XCTestCase {
    
    func test_init_GivenAddBasicGameInformationViewModel_ThenShouldSetPropertiesCorrectly() {
        // Given
        let viewModel = AddBasicGameInformationViewModel()
        
        // Then
        XCTAssertEqual(viewModel.sections.count, 1)
    }
    
    func test_loadData_GivenContainerDelegateIsSet_ThenShouldSetPropertiesCorrectly() {
        // Given
        let viewModel = AddBasicGameInformationViewModel()
        let mockDelegate = ContainerViewControllerDelegateMock()
        viewModel.containerDelegate = mockDelegate
        var callbackIsCalled = false
        
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        
        // Then
        mockDelegate.verify(
            .configureBottomView(
                contentViewFactory: .any
            ),
            count: .once
        )
        XCTAssertTrue(callbackIsCalled)
        
    }
}
