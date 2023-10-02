//
//  SelectPlatformViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 28/08/2023.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class SelectPlatformViewModelTests: XCTestCase {
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        
        // When
        let viewModel = SelectPlatformViewModel(
            cloudDatabase: cloudDatabase,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.progress, 1/3)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
        XCTAssertEqual(viewModel.searchViewModel?.placeholder, L10n.searchPlatform)
        XCTAssertEqual(viewModel.searchViewModel?.activateOnTap, false)
    }
    
    func test_loadData_GivenFirestoreReturnsNoData_ThenShouldReturnAddGameErrorServer() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getAvailablePlatforms(
                willReturn: nil
            )
        )
        
        let viewModel = SelectPlatformViewModel(
            cloudDatabase: cloudDatabase,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.loadData { error in
            // Then
            guard let error = error as? AddGameError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, AddGameError.server)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_loadData_GivenNoError_ThenShouldReturnData() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getAvailablePlatforms(
                willReturn: MockData.platforms
            )
        )
        
        let viewModel = SelectPlatformViewModel(
            cloudDatabase: cloudDatabase,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
                
        // When
        viewModel.loadData { _ in
            
            // Then
            XCTAssertEqual(viewModel.numberOfSections(), 1)
            XCTAssertEqual(viewModel.numberOfItems(in: 0), MockData.platforms.count)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_updateSearch_GivenListOfPlatforms_ThenShouldSetupSectionsAndCellsVMAccordingly() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getAvailablePlatforms(
                willReturn: MockData.platforms
            )
        )
        
        let viewModel = SelectPlatformViewModel(
            cloudDatabase: cloudDatabase,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "Game Boy") { _ in
                
                // Then
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.sections[0].cellsVM.count, 1)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_updateSearch_GivenNoMatchingPlatforms_ThenShouldReturnErrorNoItems() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getAvailablePlatforms(
                willReturn: MockData.platforms
            )
        )
        
        let viewModel = SelectPlatformViewModel(
            cloudDatabase: cloudDatabase,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "Playstation01") { error in
                guard let error = error as? AddGameError else {
                    XCTFail("Error type is not correct")
                    return
                }
                XCTAssertEqual(error, AddGameError.noItems)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_updateSearch_GivenEmptySearchQuery_ThenShouldReturnFullListOfPlatforms() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let cloudDatabase = CloudDatabaseMock()
        cloudDatabase.given(
            .getAvailablePlatforms(
                willReturn: MockData.platforms
            )
        )
        
        let viewModel = SelectPlatformViewModel(
            cloudDatabase: cloudDatabase,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "") { _ in
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.numberOfItems(in: 0), MockData.platforms.count)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_startSearch_ThenShouldCallCallback() {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let viewModel = SelectPlatformViewModel(
            cloudDatabase: cloudDatabase,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        var callbackIsCalled = false
        
        // When
        viewModel.startSearch(from: "nothing") { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_didTapRightButtonItem_ThenShouldSetNavigationStyleCorrectly() {
        // Given
        let cloudDatabase = CloudDatabaseMock()
        let viewModel = SelectPlatformViewModel(
            cloudDatabase: cloudDatabase,
            gameDetailsDelegate: GameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.didTapRightButtonItem()
        
        // Then
        let expectedNavigationStyle: NavigationStyle = {
            return .dismiss(completionBlock: nil)
        }()
        let lastNavigationStyle = Routing.shared.lastNavigationStyle
        
        XCTAssertEqual(lastNavigationStyle, expectedNavigationStyle)
    }
}
