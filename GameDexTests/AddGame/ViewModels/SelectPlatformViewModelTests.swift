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
    
    // MARK: Properties
    
    let searchPlaformsData = SearchPlatformsData(
        offset: .zero,
        numberOfPageResults: 5,
        numberOfTotalResults: 5,
        statusCode: 1,
        results: [
            PlatformData(id: 28, name: "Atari 2600"),
            PlatformData(id: 8, name: "Dreamcast"),
            PlatformData(id: 11, name: "Game Boy Color"),
            PlatformData(id: 17, name: "Jaguar"),
            PlatformData(id: 15, name: "SNES")
        ])
    
    // MARK: Setup
    
    override class func setUp() {
        super.setUp()
        Matcher.default.register(
            GetPlatformsEndpoint.self,
            match: Matcher.GetPlatformsEndpoint.matcher
        )
    }
    
    // MARK: Tests
    
    func test_init_GivenSelectPlatformViewModel_ThenShouldSetPropertiesCorrectly() {
        // Given
        let networkingSession = APIMock()
        
        // When
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
        // Then
        XCTAssertEqual(viewModel.numberOfSections(), .zero)
        XCTAssertEqual(viewModel.progress, 1/3)
        
        XCTAssertTrue(viewModel.searchViewModel.isSearchable)
        XCTAssertTrue(viewModel.searchViewModel.isActivated)
        XCTAssertEqual(viewModel.searchViewModel.placeholder, L10n.searchPlatform)
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
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
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
        
        wait(for: [expectation], timeout: 10.0)
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
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
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
        
        wait(for: [expectation], timeout: 10.0)
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
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
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
        
        wait(for: [expectation], timeout: 10.0)
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
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
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
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_loadData_GivenNoAPIError_ThenShouldReturnData() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.success(self.searchPlaformsData)
            )
        )
        
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
        let platforms = DataConverter.convert(remotePlatforms: self.searchPlaformsData.results)
        
        // When
        viewModel.loadData { _ in
            
            // Then
            XCTAssertEqual(viewModel.numberOfSections(), 1)
            XCTAssertEqual(viewModel.numberOfItems(in: 0), platforms.count)
            
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_updateSearch_GivenListOfPlatforms_ThenShouldSetupSectionsAndCellsVMAccordingly() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.success(self.searchPlaformsData)
            )
        )
        
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
        let platforms = DataConverter.convert(remotePlatforms: self.searchPlaformsData.results)
        
        viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "Game Boy") { _ in
                
                // Then
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.sections[0].cellsVM.count, 1)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_updateSearch_GivenNoMatchingPlatforms_ThenShouldReturnErrorNoItems() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.success(self.searchPlaformsData)
            )
        )
        
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
        let platforms = DataConverter.convert(remotePlatforms: self.searchPlaformsData.results)
        
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
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_updateSearch_GivenEmptySearchQuery_ThenShouldReturnFullListOfPlatforms() {
        // Given
        let expectation = XCTestExpectation(description: "perform loadData() asynchronously")
        
        let endpoint = GetPlatformsEndpoint(offset: .zero)
        let networkingSession = APIMock()
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.success(self.searchPlaformsData)
            )
        )
        
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
        let platforms = DataConverter.convert(remotePlatforms: self.searchPlaformsData.results)
        
        viewModel.loadData { _ in
            
            // When
            viewModel.updateSearchTextField(with: "") { _ in
                XCTAssertEqual(viewModel.numberOfSections(), 1)
                XCTAssertEqual(viewModel.numberOfItems(in: 0), platforms.count)
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_startSearch_ThenShouldCallCallback() {
        // Given
        let networkingSession = APIMock()
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
        var callbackIsCalled = false
        
        // When
        viewModel.startSearch(from: "nothing") { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
    }
}
