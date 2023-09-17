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
    
    // MARK: Setup
    
    override class func setUp() {
        super.setUp()
        Matcher.default.register(
            GetPlatformsEndpoint.self,
            match: Matcher.GetPlatformsEndpoint.matcher
        )
    }
    
    // MARK: Tests
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let networkingSession = APIMock()
        
        // When
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.progress, 1/3)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
        XCTAssertEqual(viewModel.searchViewModel?.placeholder, L10n.searchPlatform)
    }
    
    func test_loadData_GivenAPIErrorServer_ThenShouldReturnAddGameErrorServer() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.failure(.server)
            )
        )
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.loadData { error in
            // Then
            guard let error = error as? AddGameError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, AddGameError.server)
            XCTAssertEqual(endpoint.url, URL(string: "platforms"))
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_loadData_GivenAPIErrorWrongURL_ThenShouldReturnAddGameErrorServer() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.failure(.wrongUrl)
            )
        )
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
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
    
    func test_loadData_GivenAPIErrorNoData_ThenShouldReturnAddGameErrorServer() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.failure(.noData)
            )
        )
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
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
    
    func test_loadData_GivenAPIErrorParsing_ThenShouldReturnAddGameErrorServer() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.failure(.parsingError)
            )
        )
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
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
    
    func test_loadData_GivenNoAPIError_ThenShouldReturnData() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.success(MockData.searchPlaformsData)
            )
        )
        
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        let platforms = DataConverter.convert(
            remotePlatforms: MockData.searchPlaformsData.results
        )
        
        // When
        viewModel.loadData { _ in
            
            // Then
            XCTAssertEqual(viewModel.numberOfSections(), 1)
            XCTAssertEqual(viewModel.numberOfItems(in: 0), platforms.count)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_updateSearch_GivenListOfPlatforms_ThenShouldSetupSectionsAndCellsVMAccordingly() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.success(MockData.searchPlaformsData)
            )
        )
        
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
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
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.success(MockData.searchPlaformsData)
            )
        )
        
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
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
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.success(MockData.searchPlaformsData)
            )
        )
        
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        let platforms = DataConverter.convert(
            remotePlatforms: MockData.searchPlaformsData.results
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "") { _ in
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.numberOfItems(in: 0), platforms.count)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_startSearch_ThenShouldCallCallback() {
        // Given
        let networkingSession = APIMock()
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
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
        let networkingSession = APIMock()
        let viewModel = SelectPlatformViewModel(
            networkingSession: networkingSession,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
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
