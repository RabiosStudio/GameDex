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
    
    override class func setUp() {
        super.setUp()
        Matcher.default.register(
            GetPlatformsEndpoint.self,
            match: Matcher.GetPlatformsEndpoint.matcher
        )
    }
    
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
        
        let endpoint = GetPlatformsEndpoint()
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
        
        let endpoint = GetPlatformsEndpoint()
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
        
        let endpoint = GetPlatformsEndpoint()
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
        
        let endpoint = GetPlatformsEndpoint()
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
        
        let endpoint = GetPlatformsEndpoint()
        let networkingSession = APIMock()
        
        let data = SearchPlatformsData(platforms: [
            RemotePlatform(platformID: 28, platformName: "Atari 2600"),
            RemotePlatform(platformID: 8, platformName: "Dreamcast"),
            RemotePlatform(platformID: 11, platformName: "Game Boy Color"),
            RemotePlatform(platformID: 17, platformName: "Jaguar"),
            RemotePlatform(platformID: 15, platformName: "SNES")
        ])
        
        networkingSession.given(
            .getData(
                with: .value(endpoint),
                willReturn:  Result<SearchPlatformsData, APIError>.success(data)
            )
        )
        
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
        let platforms = DataConverter.convert(remotePlatforms: data.platforms)
        
        // When
        viewModel.loadData { _ in
            
            // Then
            XCTAssertEqual(viewModel.platformsDisplayed, platforms)
            XCTAssertEqual(viewModel.numberOfSections(), 1)
            XCTAssertEqual(viewModel.numberOfItems(in: 0), platforms.count)
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_updateSearch_GivenListOfPlatforms_ThenShouldSetupSectionsAndCellsVMAccordingly() {
        // Given
        let networkingSession = APIMock()
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        viewModel.platformsDisplayed = [
            Platform(title: "Game Boy", id: 10),
            Platform(title: "Game Boy Advance", id: 12),
            Platform(title: "Game Boy Color", id: 11),
            Platform(title: "Game Gear", id: 25),
            Platform(title: "Game Wave", id: 104),
            Platform(title: "GameCube", id: 14),
            Platform(title: "GameStick", id: 155)
        ]
        
        // When
        viewModel.updateSearch(with: "Game boy") { _ in
            XCTAssertEqual(viewModel.numberOfSections(), 1)
            XCTAssertEqual(viewModel.sections[0].cellsVM.count, 3)
        }
    }
    
    func test_updateSearch_GivenEmptyListOfPlatforms_ThenShouldReturnNoSections() {
        // Given
        let networkingSession = APIMock()
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
        // When
        viewModel.updateSearch(with: "") { _ in
            XCTAssertEqual(viewModel.numberOfSections(), .zero)
        }
    }
    
    func test_updateSearch_GivenNoMatchingPlatforms_ThenShouldReturnErrorNoItems() {
        // Given
        let networkingSession = APIMock()
        let viewModel = SelectPlatformViewModel(networkingSession: networkingSession)
        
        // When
        viewModel.updateSearch(with: "Playstation01") { error in
            guard let error = error as? AddGameError else {
                XCTFail("Error type is not correct")
                return
            }
            XCTAssertEqual(error, AddGameError.noItems)
        }
    }
}
