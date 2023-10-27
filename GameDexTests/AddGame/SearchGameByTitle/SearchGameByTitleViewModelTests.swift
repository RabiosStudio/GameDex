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
    
    func test_init_ThenShouldSetPropertiesCorrectly() {
        // Given
        let networkingSession = APIMock()
        
        // When
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.progress, 2/3)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), .zero)
        
        XCTAssertEqual(viewModel.searchViewModel?.placeholder, L10n.searchGame)
        XCTAssertEqual(viewModel.searchViewModel?.activateOnTap, false)

    }
    
    func test_loadData_ThenCallbackShouldReturnNoSearch() {
        // Given
        let networkingSession = APIMock()
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
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
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // When
        viewModel.startSearch(from: MockData.searchGameQuery) { error in
            // Then
            guard let error = error as? AddGameError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, AddGameError.server)
            XCTAssertEqual(endpoint.url, URL(string: "games"))
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
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // When
        viewModel.startSearch(from: MockData.searchGameQuery) { error in
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
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // When
        viewModel.startSearch(from: MockData.searchGameQuery) { error in
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
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // When
        viewModel.startSearch(from: MockData.searchGameQuery) { error in
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
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        let games = RemoteDataConverter.convert(
            remoteGames: MockData.searchGamesData.results,
            platform: MockData.platform
        )
        
        // When
        viewModel.startSearch(from: MockData.searchGameQuery) { _ in
            // Then
            XCTAssertEqual(viewModel.numberOfSections(), 1)
            XCTAssertEqual(viewModel.numberOfItems(in: 0), games.count)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_startSearch_GivenNoAPIErrorAndNoResult_ThenShouldReturnErrorNoItem() {
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
                willReturn:  Result<SearchGamesData, APIError>.success(MockData.searchGamesResultEmpty)
            )
        )
        
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        // When
        viewModel.startSearch(from: MockData.searchGameQuery) { error in
            // Then
            guard let error = error as? AddGameError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, AddGameError.noItems)
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
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
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
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        let games = RemoteDataConverter.convert(
            remoteGames: MockData.searchGamesData.results,
            platform: MockData.platform
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.startSearch(from: MockData.searchGameQuery) { _ in
                
                // Then
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.numberOfItems(in: 0), games.count)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: Constants.timeout)
    }
    
    func test_startSearch_GivenSearchResultsWithNoReleaseDate_ThenShouldDisplayErrorNoItems() {
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
                willReturn:  Result<SearchGamesData, APIError>.success(MockData.searchGamesResultWithoutReleaseDate)
            )
        )
        
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        
        let games = RemoteDataConverter.convert(
            remoteGames: MockData.searchGamesData.results,
            platform: MockData.platform
        )
        
        viewModel.loadData { _ in
            
            // When
            viewModel.startSearch(from: MockData.searchGameQuery) { error in
                
                // Then
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
    
    func test_didTapRightButtonItem_ThenShouldSetNavigationStyleCorrectly() {
        // Given
        let networkingSession = APIMock()
        let viewModel = SearchGameByTitleViewModel(
            networkingSession: networkingSession,
            platform: MockData.platform,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
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
