//
//  SearchGameByTitleViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 04/09/2023.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class SearchGameByTitleViewModelTests: XCTestCase {
    
    // MARK: Setup
    
    override class func setUp() {
        super.setUp()
        Matcher.default.register(
            GetGamesEndpoint.self,
            match: Matcher.GetGamesEndpoint.matcher
        )
    }
    
    // MARK: Tests
    
    func test_init_GivenSearchGameByTitleViewModel_ThenShouldSetPropertiesCorrectly() {
        // Given
        let networkingSession = APIMock()
        
        // When
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.progress, 2/3)
        
        XCTAssertEqual(viewModel.searchViewModel?.placeholder, L10n.searchGame)
    }
    
    func test_loadData_ThenCallbackShouldReturnNoSearch() {
        // Given
        let networkingSession = APIMock()
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.loadData { error in
            // Then
            guard let error = error as? AddGameError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, AddGameError.noSearch(platformName: MockData.platform.title))
        }
    }
    
    func test_startSearch_GivenAPIErrorServer_ThenShouldReturnAddGameErrorServer() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetGamesEndpoint(
            platformId: MockData.platform.id,
            title: MockData.platform.title
        )
        
        let networkingSession = APIMock()
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchGamesData, APIError>.failure(.server)
            )
        )
        
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.startSearch(from: MockData.searchQuery) { error in
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
    
    func test_startSearch_GivenAPIErrorWrongURL_ThenShouldReturnAddGameErrorServer() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetGamesEndpoint(
            platformId: MockData.platform.id,
            title: MockData.platform.title
        )
        
        let networkingSession = APIMock()
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchGamesData, APIError>.failure(.wrongUrl)
            )
        )
        
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.startSearch(from: MockData.searchQuery) { error in
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
    
    func test_startSearch_GivenAPIErrorNoData_ThenShouldReturnAddGameErrorServer() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetGamesEndpoint(
            platformId: MockData.platform.id,
            title: MockData.platform.title
        )
        
        let networkingSession = APIMock()
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchGamesData, APIError>.failure(.noData)
            )
        )
        
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.startSearch(from: MockData.searchQuery) { error in
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
    
    func test_startSearch_GivenAPIErrorParsing_ThenShouldReturnAddGameErrorServer() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetGamesEndpoint(
            platformId: MockData.platform.id,
            title: MockData.platform.title
        )
        
        let networkingSession = APIMock()
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchGamesData, APIError>.failure(.parsingError)
            )
        )
        
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        // When
        viewModel.startSearch(from: MockData.searchQuery) { error in
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
    
    func test_startSearch_GivenNoAPIError_ThenShouldReturnData() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetGamesEndpoint(
            platformId: MockData.platform.id,
            title: MockData.platform.title
        )
        
        let networkingSession = APIMock()
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchGamesData, APIError>.success(MockData.searchGamesData)
            )
        )
        
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        let games = DataConverter.convert(
            remoteGames: MockData.searchGamesData.results,
            platform: MockData.platform
        )
        
        // When
        viewModel.startSearch(from: MockData.searchQuery) { _ in
            // Then
            XCTAssertEqual(viewModel.numberOfSections(), 1)
            XCTAssertEqual(viewModel.numberOfItems(in: 0), games.count)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_updateSearchTextField_ThenShouldCallCallback() {
        // Given
        let networkingSession = APIMock()
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        var callbackIsCalled = false
        
        // When
        viewModel.updateSearchTextField(with: "nothing") { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
    }
    
    func test_startSearch_GivenSearchResults_ThenShouldSetupSectionsAndCellsVMAccordingly() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetGamesEndpoint(
            platformId: MockData.platform.id,
            title: MockData.platform.title
        )
        
        let networkingSession = APIMock()
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchGamesData, APIError>.success(MockData.searchGamesData)
            )
        )
        
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            addGameDelegate: AddGameDetailsViewModelDelegateMock()
        )
        
        let games = DataConverter.convert(
            remoteGames: MockData.searchGamesData.results,
            platform: MockData.platform
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.startSearch(from: MockData.searchQuery) { _ in
                
                // Then
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.numberOfItems(in: 0), games.count)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.timeout)
    }
}
