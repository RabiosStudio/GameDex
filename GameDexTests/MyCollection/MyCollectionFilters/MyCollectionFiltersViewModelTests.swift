//
//  MyCollectionFiltersViewModelTests.swift
//  GameDexTests
//
//  Created by Gabrielle Dalbera on 23/05/2024.
//

import XCTest
@testable import GameDex
import SwiftyMocky

final class MyCollectionFiltersViewModelTests: XCTestCase {
    
    // MARK: Tests
    
    func test_init_ThenShouldCreateNoSectionsAndItems() {
        // Given
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            selectedFilters: nil,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        // When
        let numberOfSections = viewModel.numberOfSections()
        let numberOfItems = viewModel.numberOfItems(in: .zero)
        // Then
        XCTAssertEqual(numberOfSections, .zero)
        XCTAssertEqual(numberOfItems, .zero)
    }
    
    func test_loadData_ThenCallBackIsCalledAndSectionsAreSetCorrectlyAndContainerDelegateIsCalled() {
        // Given
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            selectedFilters: nil,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        viewModel.containerDelegate = containerDelegate
        var callbackIsCalled = false
        
        // When
        viewModel.loadData { _ in
            callbackIsCalled = true
        }
        
        // Then
        XCTAssertTrue(callbackIsCalled)
        XCTAssertEqual(viewModel.numberOfSections(), 1)
        XCTAssertEqual(viewModel.numberOfItems(in: .zero), 6)
        containerDelegate.verify(.configureSupplementaryView(contentViewFactory: .any), count: .once)
    }
    
    func test_didTapPrimaryButton_GivenNoFilter_ThenMyCollectionDelegateClearFiltersIsCalledAndViewIsDismissed() async {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            selectedFilters: nil,
            myCollectionDelegate: myCollectionDelegate
        )
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        myCollectionDelegate.verify(.clearFilters(), count: .once)
        XCTAssertEqual(Routing.shared.lastNavigationStyle, .dismiss(completionBlock: nil))
    }
    
    func test_didTapPrimaryButton_GivenSelectedFilter_ThenMyCollectionDelegateApplyFiltersIsCalledAndViewIsDismissed() async {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            selectedFilters: MockData.gameFiltersWithMatchingGames,
            myCollectionDelegate: myCollectionDelegate
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTapPrimaryButton(with: nil)
        
        // Then
        myCollectionDelegate.verify(.apply(filters: .any), count: .once)
        XCTAssertEqual(Routing.shared.lastNavigationStyle, .dismiss(completionBlock: nil))
    }
    
    func test_enableSaveButtonIfNeeded_ThenConfigureBottomView() {
        // Given
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            selectedFilters: MockData.gameFiltersWithMatchingGames,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        
        // When
        viewModel.enableSaveButtonIfNeeded()
        
        // Then
        containerDelegate.verify(
            .configureSupplementaryView(
                contentViewFactory: .any
            ), count: 2
        )
    }
    
    func test_didTapCloseButtonItem_ThenViewShouldBeDismissed() async {
        // Given
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            selectedFilters: MockData.gameFiltersWithMatchingGames,
            myCollectionDelegate: MyCollectionViewModelDelegateMock()
        )
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTap(buttonItem: .close)
        
        // Then
        XCTAssertEqual(Routing.shared.lastNavigationStyle, .dismiss(completionBlock: nil))
    }
    
    func test_didTapClearButtonItem_ThenDelegateClearFiltersIsCalled() async {
        // Given
        let myCollectionDelegate = MyCollectionViewModelDelegateMock()
        let containerDelegate = ContainerViewControllerDelegateMock()
        let viewModel = MyCollectionFiltersViewModel(
            games: MockData.savedGames,
            selectedFilters: MockData.gameFiltersWithMatchingGames,
            myCollectionDelegate: myCollectionDelegate
        )
        viewModel.containerDelegate = containerDelegate
        viewModel.loadData { _ in }
        
        // When
        await viewModel.didTap(buttonItem: .clear)
        
        // Then
        containerDelegate.verify(.configureSupplementaryView(contentViewFactory: .any), count: 2)
    }
}
